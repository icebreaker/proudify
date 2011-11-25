class CoderWall
  constructor: (element, settings)->
    @renderer = new Renderer element, settings
    @badges   = []

    this.fetch 'http://coderwall.com/' + settings.username + '.json?callback=?'

  fetch: (url)->
    self = this
    $.getJSON url, (result)->
      self.badges.push( badge ) for badge in result.data.badges
      self.render()

  render: ->
    @renderer.render @badges, ( renderer, item, elements )->
      elements.link.attr( 'href', 'http://coderwall.com/' + renderer.settings.username ).attr( 'target', '_blank' ).appendTo elements.li
      $( document.createElement('img') ).attr( 'alt', item.name ).attr( 'title', item.description).attr( 'src', item.badge ).appendTo elements.link
