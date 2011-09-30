$ = jQuery
class GitHub
  constructor: ( element, settings )->
    @element  = element
    @settings = settings
    @wrapper  = $( '<div>' ).addClass( 'proudify github' ).appendTo @element
    @list     = $( '<ul>'  ).addClass( 'list' ).appendTo @wrapper
    @loading  = $( '<li>'  ).addClass( 'item loading' ).html( '<span class="desc">Loading ...</span>' ).appendTo @list
    @repositories = []

    this.fetch 'https://api.github.com/users/' + @settings.username + '/repos?callback=?'
  ,

  fetch: ( url )->
    self = this
    $.getJSON url, ( result )->
      self.repositories.push repository for repository in result.data
      if result.meta && result.meta.Link
        if result.meta.Link[0][1]['rel'] == 'first'
          self.render()
        else
          self.fetch result.meta.Link[0][0] + '&callback=?'
       else
        self.render()
  ,

  render: ->
    pushed_at = new Date()
    pushed_at.setDate new Date().getDate() - @settings.pushed_at
    @loading.remove()
    self = this
    $.each @repositories.sort( (a, b)-> new Date( b.pushed_at ) - new Date( a.pushed_at ) ), ( i, item )->
      return        if item.fork == true && self.settings.forks == false
      return false  if self.settings.num > 0 && i == self.settings.num

      li = $('<li>').addClass( 'item' ).appendTo self.list
      $('<a>').attr('href', item.html_url).attr('target', '_blank').html( item.name ).appendTo li
      $('<span>').addClass( 'desc' ).html( item.description ).appendTo li

      if new Date(item.pushed_at) > pushed_at
        $('<span>').addClass( 'status green' ).html( 'ONGOING' ).appendTo li
      else
        $('<span>').addClass('status red').html( 'ON HOLD' ).appendTo li

    @element

class CoderWall
  constructor: (element, settings)->
    @element  = element
    @settings = settings
    @wrapper  = $( '<div>' ).addClass( 'proudify coderwall' ).appendTo @element
    @list     = $( '<ul>' ).addClass( 'list' ).appendTo @wrapper
    @loading  = $( '<li>' ).addClass( 'item loading' ).html( '<span class="desc">Loading ...</span>' ).appendTo @list
    @badges   = []

    this.fetch 'http://coderwall.com/' + @settings.username + '.json?callback=?'
  ,
  fetch: (url)->
    self = this
    $.getJSON url, (result)->
      self.badges.push( badge ) for badge in result.data.badges
      self.render()
  ,
  render: ->
    @loading.remove()
    self = this
    $.each @badges, (i,item)->
      li    = $( '<li>' ).addClass( 'item' ).appendTo self.list
      link  = $( '<a>' ).attr('href', 'http://coderwall.com/' + self.settings.username ).attr( 'target', '_blank' ).appendTo li

      $('<img>').attr( 'alt', item.name ).attr( 'title', item.description).attr( 'src', item.badge ).appendTo link

    $('<div>').css( 'clear', 'both' ).appendTo @list

$.fn.extend {
  proudify: (options)->
    VERSION = [0,1,0]

    services = github: GitHub, coderwall: CoderWall
    settings = $.extend {}, {
      username:   false,
      service:    'github',
      pushed_at:  120,
      num:        0,
      forks:      false,
      devel:      false
    }, options || {}

    new services[ settings.service ]( this, settings ) if settings.username
    this
}
