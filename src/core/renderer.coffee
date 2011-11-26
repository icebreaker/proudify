$ = jQuery

class Renderer
  constructor: ( element, settings )->
    @element    = element
    @settings   = settings
    wrapper     = $( document.createElement( 'div' ) ).addClass( 'proudify ' + @settings.service ).appendTo element
    @list       = $( document.createElement( 'ul'  ) ).addClass( 'list' ).appendTo wrapper
    @preloader  = $( document.createElement( 'li'  ) ).addClass( 'item loading' ).appendTo @list
    message     = $( document.createElement( 'span') ).addClass( 'desc' ).html( @settings.loading_message ).appendTo @preloader

  render: (collection, render_action)->
    @preloader.remove()
    self      = this

    $.each collection, (i, item)->
      if item.git_url
        return        if item.fork && ! self.settings.forks
        return false  if self.settings.num > 0 && i == settings.num

      elements = {
        li:   $( document.createElement( 'li' ) ).addClass('item').appendTo( self.list ),
        link: $( document.createElement( 'a' ) )
      }

      render_action( self, item, elements )

    @element
