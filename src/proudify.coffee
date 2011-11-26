$.fn.extend {
  proudify: (options)->
    VERSION = [0,1,0]

    services = github: GitHub, coderwall: CoderWall
    settings = $.extend {}, {
      username:         false,
      service:          'github',
      pushed_at:        120,
      num:              0,
      forks:            false,
      devel:            false,
      loading_message:  'Loading ...',
      ongoing_status:   'ONGOING',
      onhold_status:    'ON HOLD'
    }, options || {}

    new services[ settings.service ]( this, settings ) if settings.username
    this
}
