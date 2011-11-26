class CoderWall extends Service
  url: ->
   'http://coderwall.com/' + @settings.username + '.json'

  collect: ( result ) ->
    @data.push( badge ) for badge in result.data.badges

  render: ->
    super @data, ( service, item, elements ) ->
      elements.link.attr( 'href', 'http://coderwall.com/' + service.settings.username ).attr( 'target', '_blank' ).appendTo elements.li
      service.create( 'img', { 'alt': item.name, 'title': item.description, 'src': item.badge } ).appendTo elements.link
