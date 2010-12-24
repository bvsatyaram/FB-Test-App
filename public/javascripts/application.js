// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  FB.init({
    appId  : '127104050685557',
    status : true, // check login status
    cookie : true, // enable cookies to allow the server to access the session
    xfbml  : true  // parse XFBML
  });
});


function publishResponse(response)
{
  if (response && response.post_id) {
    alert('Post was published.');
    // generateFlash(response.session);
  } else {
    alert('Post was not published.');
  }
}

function publishToWall()
{
  publish = {
    method: 'feed',
    message: 'Its great!!',
    name: 'Chronus Test App',
    caption: 'The new Facebook Graph API',
    description: (
      'At Facebook\'s core is the social graph; people and the connections they have ' +
      'to everything they care about. The Graph API presents a simple, consistent view ' +
      'of the Facebook social graph, uniformly representing objects in the graph ' +
      '(e.g., people, photos, events, and pages) and the connections between them ' +
      '(e.g., friend relationships, shared content, and photo tags).'
      ),
    link: 'http://chronus.com/',
    picture: 'http://chronus.com/images/chronus-logo.png',
    actions: [
    {
      name: 'chronus',
      link: 'http://chronus.com/'
    }
    ],
    display: 'popup',
    session_key: FB.getSession()
  };
  
  FB.ui(publish, publishResponse);
}

