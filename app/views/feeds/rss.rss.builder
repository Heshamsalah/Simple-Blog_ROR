# This file is for the RSS feed view

xml.instruct!
xml.rss version: '2.0', 'xmlns:atom': 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'Blog Posts' #feed title
    xml.description 'Simple Blog'#Feed description
    xml.link root_url #URL for the main page of the site
    xml.language 'en'
    xml.tag! 'atom:link', rel: 'self', type: 'application/rss+xml', href: feed_url

    for post in @posts #get all the posts and put them in an xml item
      xml.item do #get all post related data
        xml.title post.title
        xml.link post_url(post)
        xml.pubDate(post.created_at.rfc2822)
        xml.description(h(post.body))
      end #xml.item
    end #for
    
  end #xml.channel

end #xml.rss
