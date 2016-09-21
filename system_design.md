========================================================================

#How would you implement the Google search?

#Consider the meta-point: what is the interviewer looking for?

A mammoth question like that isn't looking for you to waste your time in the nitty-gritty of implementing a PageRank-type algorithm or how to do distributed indexing. Instead, focus on the complete picture of what it would take. It sounds like you already know all of the big pieces (BigTable, PageRank, Map/Reduce). So the question is then, how do you actually wire them together?

Here's my stab.

#Phase 1: Indexing Infrastructure (spend 5 minutes explaining)

The first phase of implementing Google (or any search engine) is to build an indexer. This is the piece of software that crawls the corpus of data and produces the results in a data structure that is more efficient for doing reads.

To implement this, consider two parts: a crawler and indexer.

The web crawler's job is to spider web page links and dump them into a set. The most important step here is to avoid getting caught in infinite loop or on infinitely generated content. Place each of these links in one massive text file (for now).

Second, the indexer will run as part of a Map/Reduce job. (Map a function to every item in the input, and then Reduce the results into a single 'thing'.) The indexer will take a single web link, retrieve the website, and convert it into an index file. (Discussed next.) The reduction step will simply be aggregating all of these index files into a single unit. (Rather than millions of loose files.) Since the indexing steps can be done in parallel, you can farm this Map/Reduce job across an arbitrarily-large data center.

#Phase 2: Specifics of Indexing Algorithms (spend 10 minutes explaining)

Once you have stated how you will process web pages, the next part is explaining how you can compute meaningful results. The short answer here is 'a lot more Map/Reduces', but consider the sorts of things you can do:

For each web site, count the number of incoming links. (More heavily linked-to pages should be 'better'.)
For each web site, look at how the link was presented. (Links in an < h1 > or < b > should be more important than those buried in an < h3 >.)
For each web site, look at the number of outbound links. (Nobody likes spammers.)
For each web site, look at the types of words used. For example, 'hash' and 'table' probably means the web site is related to Computer Science. 'hash' and 'brownies' on the other hand would imply the site was about something far different.
Unfortunately I don't know enough about the sorts of ways to analyze and process the data to be super helpful. But the general idea is scalable ways to analyze your data.

#Phase 3: Serving Results (spend 10 minutes explaining)

The final phase is actually serving the results. Hopefully you've shared some interesting insights in how to analyze web page data, but the question is how do you actually query it? Anecdotally 10% of Google search queries each day have never been seen before. This means you cannot cache previous results.

You cannot have a single 'lookup' from your web indexes, so which would you try? How would you look across different indexes? (Perhaps combining results -- perhaps keyword 'stackoverflow' came up highly in multiple indexes.)

Also, how would you look it up anyways? What sorts of approaches can you use for reading data from massive amounts of information quickly? (Feel free to namedrop your favorite NoSQL database here and/or look into what Google's BigTable is all about.) Even if you have an awesome index that is highly accurate, you need a way to find data in it quickly. (E.g., find the rank number for 'stackoverflow.com' inside of a 200GB file.)

#Random Issues (time remaining)

Once you have covered the 'bones' of your search engine, feel free to rat hole on any individual topic you are especially knowledgeable about.

Performance of the website frontend
Managing the data center for your Map/Reduce jobs
A/B testing search engine improvements
Integrating previous search volume / trends into indexing. (E.g., expecting frontend server loads to spike 9-5 and die off in the early AM.)
There's obviously more than 15 minutes of material to discuss here, but hopefully it is enough to get you started.

Build a Web Crawler

Let’s talk about this popular system design interview question – How to build a web crawler?

Web crawlers are one of the most common used systems nowadays. The most popular example is that Google is using crawlers to collect information from all websites. Besides search engine, news websites need crawlers to aggregate data sources. It seems that whenever you want to aggregate a large amount of information, you may consider using crawlers.

There are quite a few factors when building a web crawler, especially when you want to scale the system. That’s why this has become one of the most popular system design interview questions. In this post, we are going to cover topics from basic crawler to large-scale crawler and discuss various questions you may be asked in an interview.

===============================================================================

#1 – Basic solution
How to build a rudimentary web crawler?

One simple idea we’ve talked about in 8 Things You Need to Know Before a System Design Interview is to start simple. Let’s focus on building a very rudimentary web crawler that runs on a single machine with single thread. With this simple solution, we can keep optimizing later on.

To crawler a single web page, all we need is to issue a HTTP GET request to the corresponding URL and parse the response data, which is kind of the core of a crawler. With that in mind, a basic web crawler can work like this:

Start with a URL pool that contains all the websites we want to crawl.
For each URL, issue a HTTP GET request to fetch the web page content.
Parse the content (usually HTML) and extract potential URLs that we want to crawl.
Add new URLs to the pool and keep crawling.
It depends on the specific problem, sometimes we may have a separate system that generates URLs to crawl. For instance, a program can keep listening to RSS feeds and for every new article, it can add the URL into the crawling pool.

 

#2 – Scale issues
As is known to all, any system will face a bunch of issues after scaling. In a web crawler, there are tons of things that can make it wrong when scaling the system to multiple machines.

Before jumping to the next session, please spend a couple of minutes thinking about what can be bottlenecks of a distributed web crawler and how would you solve them. In rest of the post, we are going to talk about several major issues with solutions.

 

#3 – Crawling frequency
How often will you crawl a website?

This may not sound like a big deal unless the system comes to certain scales and you need very fresh content. For example, if you want to get the latest news from last hour, your crawler may need to keep crawling the news website every hour. But what’s wrong with this?

For some small websites, it’s very likely that their servers cannot handle such frequent request. One approach is to follow the robot.txt of each site. For people who don’t know what robot.txt is, basically it’s a standard used by websites to communicate with web crawlers. It can specify things like what files should not be crawled and most web crawlers will follow the configuration. In addition, you can have different crawl frequency for different websites. Usually, there are only a few sites that need to be crawled multiple times per day.

 

#4 – Dedup
In a single machine, you can keep the URL pool in memory and remove duplicate entries. However, things become more complicated in a distributed system. Basically multiple crawlers may extract the same URL from different web pages and they all want to add this URL to the URL pool. Of course, it doesn’t make sense to crawl the same page multiple times. So how can we dedup these URLs?

One common approach is to use Bloom Filter. In a nutshell, a bloom filter is a space-efficient system that allows you to test if an element is in a set. However, it may have false positive. In other words, if a bloom filter can tell you either a URL is definitely not in the pool or it probably in the pool.

To briefly explain how bloom filter works, an empty bloom filter is a bit array of m bits (all 0). There are also k hash functions that map each element to one of the m bits. So when we add a new element (URL) into the bloom filter, we will get k bits from the hash functions and set all of them to 1. Thus, when we check the existence of an element, we first get the k bits for it and if any of them is not 1, we know immediately that the element doesn’t exist. However, if all of the k bits are 1, this can come from the combination of several other elements.

Bloom filter is a very commonly used technique and it’s the perfect solution for deduping URLs in a web crawler.

 

#5 – Parsing
After fetching the response data from the site, the next step is to parse the data (usually HTML) to extract the information we care about. This sounds like a simple thing, however, it can be quite hard to make it robust.

The challenge is that you will always find strange markups, URLs etc. in the HTML code and it’s hard to cover all corner cases. For instance, you may need to handle encode/decode issue when the HTML contains non-unicode characters. In addition, when the web page contains images, videos or even PDF, it can also cause weird behaviors.

In addition, some web pages are all rendered through Javascript like using AngularJS, your crawler may not be able
to get any content at all.

I would say there’s no silver bullet that can make a perfect and robust crawler for all web pages. You need tons of robustness tests to make sure that it can work as expected.

 

# Summary
There are many other interesting topics I haven’t covered yet, but I’d like to mention few of them so that you can think about it. One thing is to detect loops. Many websites contain links like A→B->C->A and your crawler may end up running forever. Think about how to fix this?

Another problem is DNS lookup. When the system get scaled to certain level, DNS lookup can be a bottleneck and you may build your own DNS server.

Similar to many other systems, scaling the web crawler can be much more difficult than building a single machine version and there are lots of things that can be discussed in a system design interview. Try to start with some naive solution and keep optimizing on top of it, which can make things much easier than they seem to be.

===============================================================

# Design a URL shortener

1. is this a full web app, with a web interface?
  Let's just build an API to start
2. Since it's an API, do we need authentication or user accounts or developer keys? 
3. do Links persist forever, do we automatically remove old ones? 
4. let people choose thier shortlink, or just always auto-generate?
5. do we need analytics, so people can see how many people are clicking on a link? 

# Design Goals
  - we should be able to store a lot of links, since we're not automatically expiring them.
  - out shortlinks should be as short as possible. The whole point of a link shortnere is to make short links. Having shorter links than our competition could be a business advantage
  - Following a shortlink should be fast
  - The shortlink follower should be resilient to load spikes. One of our links might be the top story on Reddit. 

# Data Model

Link
  - short_link
  - long_link

of course we don't need to store the full ShortLink URL, we just need to store the slug the part at the end

ShortLink 
  - slug
  - destination

= investing time in carefully naming things from the beginning is always impressive in an interview. A big part of code readability is how well things are named. 

In normal REST style, our endpoint for creating a ShortLink should be named after the entity we're creating. Versioning apis is also a reasonable thing to do. So let's put our creation endpoint at ca.ke/api/v1/shortlink.

To create a new ShortLink, we'll send a POST request there. Our POST request will include one required argument: the destination where our ShortLink will point. It'll also optionally take a slug argument. If no slug is provided, we'll generate one. The response will contain the newly-created ShortLink, including its slug and destination. 

Two main types of databases these days: Relational databases (RDBMs) like MySQL and Postgres and NoSQL- style databaes like BigTable and Cassandra. 

Relational databses are great for systems where you expect to make lots of complex queries involving joins and such - in other words, they're good if you're planning to look at the relationships between things a lot. NoSQL databases don't handle these things quite as well, but in exchange they're faster for writes and simple key-value reads. 

For our app, it seems like relational queries aren't likely to be a big part of our app's functionality, even if we added a few of the obvious next features we might want. So let's go with NoSQL for this. 

Configure databae to use more space for its cache. If reads are still slow we could add a caching layer, like memcached. It adds complexity because we now have two sources of truth, and we need to be careful to keep them in sync. For example, if we let users edit their links, we need to push those edits to both the database adn the cache. 
  Adding a caching layer:
    1. the eviction strategy. If the cache is full, what do we remove to make space? The most common answer is an LRU (least recently used) strategy. 
    2. sharding strategy. Sharding our cache lets us store more stuff in memory, because we can use more machines. But how do we store more stuff in memory, because we can use more machines. But how do we decide which things go on which shard? THe common answer is a "hash and mod strategy" - hash the key, mod the result by the number of shards, and you get a shard number to send your request to. But then how do you add or remove a shard without causing an unmanageable spike in cache misses? 

