$.fn.extend {
  proudify: ( options )->
    VERSION = [0,2,0]

    services = github: GitHub, coderwall: CoderWall, codeschool: CodeSchool
    settings = $.extend {}, {
      username:         false,
      service:          'github',
      pushed_at:        120,
      num:              0,
      forks:            false,
      loading_message:  'Loading ...',
      ongoing_status:   'ONGOING',
      onhold_status:    'ON HOLD'
    }, options || {}

    new services[ settings.service ]( this, settings ) if settings.username
    this
}
