class GitHub
  constructor: ( element, settings )->
    @settings     = settings
    @renderer     = new Renderer element, settings
    @repositories = []

    this.fetch 'https://api.github.com/users/' + settings.username + '/repos?callback=?'

  fetch: ( url )->
    self = this
    $.getJSON url, ( result )->
      self.repositories.push repository for repository in result.data
      self.render()

  render: ->
    pushed_at     = new Date().setDate( new Date().getDate() - @settings.pushed_at )
    sorted_repos  = @repositories.sort( (a, b)-> new Date( b.pushed_at ) - new Date( a.pushed_at ) )

    @renderer.render sorted_repos, ( renderer, item, elements )->
      elements.link.attr( 'href', item.html_url ).attr( 'target', '_blank' ).html( item.name ).appendTo elements.li
      $( document.createElement( 'span' ) ).addClass( 'desc' ).html( item.description ).appendTo elements.li

      if new Date( item.pushed_at ) > pushed_at
        $( document.createElement( 'span' ) ).addClass( 'status green' ).html( renderer.settings.ongoing_status ).appendTo elements.li
      else
        $( document.createElement( 'span' ) ).addClass( 'status red' ).html( renderer.settings.onhold_status  ).appendTo elements.li
