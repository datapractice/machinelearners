from gdata.youtube import service

gl  = open('/home/mackenza/glogin.txt')
details  = gl.readlines()

USERNAME = details[0]
PASSWORD = details[1]
VIDEO_ID = 'wf_IIbT8HGk'


def comments_generator(client, video_id):
    comment_feed = client.GetYouTubeVideoCommentFeed(video_id=video_id)
    while comment_feed is not None:
        for comment in comment_feed.entry:
            yield comment
        next_link = comment_feed.GetNextLink()
        if next_link is None:
            comment_feed = None
        else:
            comment_feed = client.GetYouTubeVideoCommentFeed(next_link.href)

def get_comments(client, VIDEO_ID):
    comments = []
    for comment in comments_generator(client, VIDEO_ID):
        author_name = comment.author[0].name.text
        text = comment.content.text
        comments.append({author_name: text})
    return comments

client = service.YouTubeService()
client.ClientLogin(USERNAME, PASSWORD)

c = get_comments(client, VIDEO_ID)
len(c)
c[0]
