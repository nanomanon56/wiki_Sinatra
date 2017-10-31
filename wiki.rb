require "sinatra"
require "uri"
#takes the a page title and use its to load the contents of a text fle 
def page_content(title)
	File.read("pages/#{title}.txt")
 rescue Errno::ENOENT
 	return nil
 end 

#saves a files content to the directory 
def save_content(title, content)
	File.open("pages/#{title}.txt" , "w") do |file|
	 file.print(content)
 end 		
end	

#this leads me to my home page 
get "/" do 
	erb :welcome
end	
#this leads me to my new post page 
get "/new" do
erb :new
end 
#this goes to my views file and to my show.erb, This will change my title and content 
get "/:title" do
@title = params[:title] 
@content = page_content(@title)
erb :show 
end 	

#This saves my posts into the pages file, and redirects me to what my post was  
#{"title"=>"tuyre", "content"=>"jytrsvfe", "submit"=>"Submit"} this is what it looks like 
post "/create" do
	save_content(params["title"], params["content"])
	redirect URI.escape("/#{params['title']}")
end
