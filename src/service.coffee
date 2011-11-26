$ = jQuery

class Service
  constructor: ( @element, @settings ) ->
    @data       = []
    wrapper     = this.create( 'div',  { 'class': 'proudify ' + @settings.service } ).appendTo @element
    @list       = this.create( 'ul' ).appendTo wrapper
    @preloader  = this.create( 'li' ,  { 'class': 'loading' } ).appendTo @list
    message     = this.create( 'span', { 'class': 'desc', 'html': @settings.loading_message } ).appendTo @preloader

    this.fetch this.url()

  url: ->
    ''

  fetch:( url ) ->
    self = this

    if url.length == 0
      return
    
    if url.indexOf('?') == -1
      suffix = '?'
    else
      suffix = '&'
    
    suffix += 'callback=?'

    $.getJSON url + suffix, ( result ) ->
      self.collect result

      next = self.paginate result
      if next
        self.fetch next
      else
        self.render()
     
  collect: ( result ) ->
    @data.push( item ) for item in result.data

  paginate: ( result ) ->
    false

  create: ( type, attributes ) ->
    $( "<#{type}/>", attributes )

  render: ( collection, callback ) ->
    @preloader.remove()
    self = this

    $.each collection, ( i, item ) ->
      if item.git_url
        return        if item.fork && ! self.settings.forks
        return false  if self.settings.num > 0 && i == settings.num

      elements = {
        li:   self.create( 'li' ).appendTo( self.list ),
        link: self.create( 'a' )
      }

      callback( self, item, elements )

    @element
