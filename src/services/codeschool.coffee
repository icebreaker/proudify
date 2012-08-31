class CodeSchool extends Service
  url: ->
   "http://www.codeschool.com/users/#{@settings.username}.json"

  collect: ( result ) ->
    @data.push( badge ) for badge in result.badges

  render: ->
    super @data, ( service, item, elements ) ->
      elements.link.attr( 'href', 'http://www.codeschool.com/users/' + service.settings.username ).attr( 'target', '_blank' ).appendTo elements.li
      service.create( 'img', { 'alt': item.name, 'title': item.name, 'src': item.badge } ).appendTo elements.link
