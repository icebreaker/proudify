class GitHub extends Service
  url: ->
    'https://api.github.com/users/' + @settings.username + '/repos'

  paginate: ( result ) ->
    if result.meta && result.meta.Link && result.meta.Link[0][1]['rel'] != 'first'
      result.meta.Link[0][0]
    else
      false

  render: ->
    pushed_at     = new Date().setDate( new Date().getDate() - @settings.pushed_at )
    sorted_repos  = @data.sort( (a, b)-> new Date( b.pushed_at ) - new Date( a.pushed_at ) )

    super sorted_repos, ( service, item, elements ) ->
      elements.link.attr( 'href', item.html_url ).attr( 'target', '_blank' ).html( item.name ).appendTo elements.li
      service.create('span', { 'class': 'desc', 'html': item.description } ).appendTo elements.li

      if service.settings.num_forks
        service.create( 'span', { 'class': 'counters', 'html': 'Forks: ' + item.forks } ).appendTo elements.li

      if service.settings.num_watchers
        service.create( 'span', { 'class': 'counters', 'html': 'Watchers: ' + item.watchers } ).appendTo elements.li

      if new Date( item.pushed_at ) > pushed_at
        service.create( 'span', { 'class': 'status green', 'html': service.settings.ongoing_status } ).appendTo elements.li
      else
        service.create( 'span', { 'class': 'status red', 'html': service.settings.onhold_status } ).appendTo elements.li
