<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="no" />

<xsl:variable name="image-dir">images</xsl:variable>
<xsl:variable name="icon-dir">images</xsl:variable>
<xsl:variable name="video-dir">videos</xsl:variable>
<xsl:variable name="dl-dir">downloads</xsl:variable>
<xsl:variable name="github-icon">github.png</xsl:variable>
<xsl:variable name="mail-icon">gmail.png</xsl:variable>
<xsl:variable name="website-icon">world.png</xsl:variable>
<xsl:variable name="dl-icon">download.png</xsl:variable>

<xsl:template match="/portfolio">
<html>
  <head>
    <title><xsl:value-of select="name" /></title>
    <link rel="stylesheet" type="text/css" href="portfolio.css" />
    <link rel="shortcut icon" type="image/x-icon" href="{$icon-dir}/icon.png" />
    <script src="portfolio.js"></script>
  </head>
  <body onload="javascript:initialize();">
    <div class="everything">
      <div class="page">
        <div class="header">
          <div class="logo" />
          <div class="title">
            <xsl:value-of select="name" /><br />
            <xsl:apply-templates select="links" />
          </div>
        </div>
        <div class="content">
          <ol class="navbar">
            <xsl:for-each select="item">
            <xsl:variable name="item-id"><xsl:value-of select="id" /></xsl:variable>
            <li class="selected"><a href="#{$item-id}"><xsl:value-of select="name" /></a></li>
            </xsl:for-each>
          </ol>
          <ol class="items">
            <xsl:apply-templates select="item" />
          </ol>
        </div>
      </div>
    </div>
  </body>
</html>
</xsl:template>

<xsl:template match="item">
<xsl:variable name="item-id"><xsl:value-of select="id" /></xsl:variable>
<li id="{$item-id}">
  <p class="name"><xsl:value-of select="name" /></p>
  <xsl:apply-templates select="gallery">
    <xsl:with-param name="item-id" select="$item-id"/>
  </xsl:apply-templates>
  <div class="summary"><xsl:copy-of select="summary/node()" /></div>
  <xsl:apply-templates select="links" />
</li>
</xsl:template>

<xsl:template match="links">
  <ul class="links">
    <xsl:apply-templates select="website | github | file | email" />
  </ul>
</xsl:template>

<xsl:template match="website">
<li><a class="website" href="{.}" target="_blank">
  <xsl:choose>
    <xsl:when test="@icon">
      <img src="{$icon-dir}/{@icon}" class="link-icon" />
    </xsl:when>
    <xsl:otherwise>
      <img src="{$icon-dir}/{$website-icon}" class="link-icon" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="@name">
      <xsl:value-of select="@name" />
    </xsl:when>
    <xsl:otherwise>Website</xsl:otherwise>
  </xsl:choose>
</a></li>
</xsl:template>

<xsl:template match="github">
<li><a class="github" href="{.}" target="_blank">
  <xsl:choose>
    <xsl:when test="@icon">
      <img src="{$icon-dir}/{@icon}" class="link-icon" />
    </xsl:when>
    <xsl:otherwise>
      <img src="{$icon-dir}/{$github-icon}" class="link-icon" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="@name">
      <xsl:value-of select="@name" />
    </xsl:when>
    <xsl:otherwise>Github Repository</xsl:otherwise>
  </xsl:choose>
</a></li>
</xsl:template>

<xsl:template match="file">
<li><a class="download" href="{$dl-dir}/{.}" target="_blank">
  <xsl:choose>
    <xsl:when test="@icon">
      <img src="{$icon-dir}/{@icon}" class="link-icon" />
    </xsl:when>
    <xsl:otherwise>
      <img src="{$icon-dir}/{$dl-icon}" class="link-icon" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="@name">
      <xsl:value-of select="@name" />
    </xsl:when>
    <xsl:otherwise>Download</xsl:otherwise>
  </xsl:choose>
</a></li>
</xsl:template>

<xsl:template match="email">
<li><a class="email" target="_blank">
  <xsl:attribute name="href">mailto:<xsl:value-of select="address" /><xsl:if test="subject or text">?</xsl:if><xsl:if test="subject">subject=<xsl:value-of select="subject" /></xsl:if><xsl:if test="subject and text">&amp;</xsl:if><xsl:if test="text">body=<xsl:value-of select="text" /></xsl:if>
  </xsl:attribute>
  <xsl:choose>
    <xsl:when test="@icon">
      <img src="{$icon-dir}/{@icon}" class="link-icon" />
    </xsl:when>
    <xsl:otherwise>
      <img src="{$icon-dir}/{$mail-icon}" class="link-icon" />
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="@name">
      <xsl:value-of select="@name" />
    </xsl:when>
    <xsl:otherwise>Email</xsl:otherwise>
  </xsl:choose>
</a></li>
</xsl:template>

<xsl:template match="gallery">
<xsl:param name="item-id"/>
<div class="gallery">
  <ol class="gallery-links">
    <xsl:for-each select="image | video | youtube">
    <xsl:variable name="gallery-id">
      <xsl:value-of select="$item-id" />-gallery-<xsl:number />
    </xsl:variable>
    <li class="selected"><a href="#{$gallery-id}"><xsl:number /></a></li>
    </xsl:for-each>
  </ol>
  <ol class="gallery-items">
    <xsl:apply-templates match="image | video | youtube">
      <xsl:with-param name="item-id" select="$item-id"/>
    </xsl:apply-templates>
  </ol>
</div>
</xsl:template>

<xsl:template match="image">
<xsl:param name="item-id"/>
<xsl:variable name="gallery-id">
  <xsl:value-of select="$item-id" />-gallery-<xsl:number />
</xsl:variable>
<li id="{$gallery-id}"><div class="wrapper">
  <img src="{$image-dir}/{.}" />
</div></li>
</xsl:template>

<xsl:template match="video">
<xsl:param name="item-id"/>
<xsl:variable name="gallery-id">
  <xsl:value-of select="$item-id" />-gallery-<xsl:number />
</xsl:variable>
<li id="{$gallery-id}"><div class="wrapper">
  <video controls="true">
  <xsl:if test="@volume">
    <xsl:attribute name="onloadstart">javascript:setVolume(this, <xsl:value-of select="@volume" />);</xsl:attribute>
  </xsl:if>
  <xsl:for-each select="source">
    <source src="{$video-dir}/{.}" type="{@type}" />
  </xsl:for-each>
  </video>
</div></li>
</xsl:template>

<xsl:template match="youtube">
<xsl:param name="item-id"/>
<xsl:variable name="gallery-id">
  <xsl:value-of select="$item-id" />-gallery-<xsl:number />
</xsl:variable>
<li id="{$gallery-id}"><div class="wrapper">
  <iframe id="ytplayer" type="text/html" class="youtube" frameborder="0"
          src="https://www.youtube.com/embed/{.}"/>
</div></li>
</xsl:template>

</xsl:stylesheet>