function select(link) {
  var item = link.parentNode;
  var objects = item.parentNode.nextSibling.childNodes;
  if (item.parentNode.className == "navbar" ||
      item.parentNode.className == "gallery-links")
  {
    var siblings = item.parentNode.childNodes;
    var index = 0;
    for (var i = 0; i < siblings.length; ++i)
    {
      if (item.isSameNode(siblings[i]))
      {
        index = i;
        item.setAttribute("class", "selected");
      }
      else
      {
        siblings[i].removeAttribute("class");
      }
    }
    index = (index >= objects.length) ? 0 : index;
    for (var j = 0; j < objects.length; ++j)
    {
      if (objects[j].tagName != "LI")
      {
        if (j <= index)
        {
          ++index;
        }
      }
      else if (j == index)
      {
        objects[j].removeAttribute("style");
        
        var videos = objects[j].getElementsByTagName("VIDEO")
        for (var k = 0; k < videos.length; k++)
        {
          if (videos[k].parentNode.parentNode.style.display != "none")
          {
            videos[k].play();
          }
        }
      }
      else
      {
        objects[j].setAttribute("style", "display: none;");
        var videos = objects[j].getElementsByTagName("VIDEO");
        for (var k = 0; k < videos.length; k++)
        {
          if (!videos[k].ended && !videos[k].paused)
          {
            videos[k].pause();
          }
        }
      }
    }
  }
}

function toggle(gallery) {
  if (gallery.className == "clickable-gallery")
  {
    gallery.setAttribute("class", "gallery-overlay");
  }
  else if (gallery.className == "gallery-overlay")
  {
    gallery.setAttribute("class", "clickable-gallery");
  }
}

function doNotBubble(event)
{
  if(event.stopPropagation)
  {
    event.stopPropagation();
  }
  else
  {
    event.cancelBubble=true;
  }
}

function setVolume(video, volume)
{
    video.volume = volume;
}

function initialize()
{
    var galleries = document.getElementsByClassName("gallery");
    while (0 < galleries.length)
    {
      var galleryLinks = galleries[0].firstChild.childNodes;
      for (var j = 0; j < galleryLinks.length; ++j)
      {
        var galleryLink = galleryLinks[j].firstChild;
        galleryLink.setAttribute("onclick", "javascript:select(this);doNotBubble(event);");
        galleryLink.removeAttribute("href");
      }
      select(galleryLinks[0].firstChild);
      galleries[0].setAttribute("onclick", "javascript:toggle(this);");
      galleries[0].setAttribute("class", "clickable-gallery");
    }

    var navbar = document.getElementsByClassName("navbar")[0];
    
    var selected = false;
    for (var i = 0; i < navbar.childNodes.length; ++i)
    {
      var link = navbar.childNodes[i].firstChild;
      if(link.getAttribute("href") === window.location.hash)
      {
        select(link);
        selected = true;
      }
      link.setAttribute("onclick", "javascript:select(this);");
      link.removeAttribute("href");
    }
    
    if (!selected)
    {
      select(navbar.firstChild.firstChild);
    }
}