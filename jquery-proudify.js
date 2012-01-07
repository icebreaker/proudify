(function() {
  var $, CoderWall, GitHub, Service;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  $ = jQuery;
  Service = (function() {
    function Service(element, settings) {
      var message, wrapper;
      this.element = element;
      this.settings = settings;
      this.data = [];
      wrapper = this.create('div', {
        'class': 'proudify ' + this.settings.service
      }).appendTo(this.element);
      this.list = this.create('ul').appendTo(wrapper);
      this.preloader = this.create('li', {
        'class': 'loading'
      }).appendTo(this.list);
      message = this.create('span', {
        'class': 'desc',
        'html': this.settings.loading_message
      }).appendTo(this.preloader);
      this.fetch(this.url());
    }
    Service.prototype.url = function() {
      return '';
    };
    Service.prototype.fetch = function(url) {
      var self, suffix;
      self = this;
      if (url.length === 0) return;
      if (url.indexOf('?') === -1) {
        suffix = '?';
      } else {
        suffix = '&';
      }
      suffix += 'callback=?';
      return $.getJSON(url + suffix, function(result) {
        var next;
        self.collect(result);
        next = self.paginate(result);
        if (next) {
          return self.fetch(next);
        } else {
          return self.render();
        }
      });
    };
    Service.prototype.collect = function(result) {
      var item, _i, _len, _ref, _results;
      _ref = result.data;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(this.data.push(item));
      }
      return _results;
    };
    Service.prototype.paginate = function(result) {
      return false;
    };
    Service.prototype.create = function(type, attributes) {
      return $("<" + type + "/>", attributes);
    };
    Service.prototype.render = function(collection, callback) {
      var self;
      this.preloader.remove();
      self = this;
      $.each(collection, function(i, item) {
        var elements;
        if (item.git_url) {
          if (item.fork && !self.settings.forks) return;
          if (self.settings.num > 0 && i === settings.num) return false;
        }
        elements = {
          li: self.create('li').appendTo(self.list),
          link: self.create('a')
        };
        return callback(self, item, elements);
      });
      return this.element;
    };
    return Service;
  })();
  CoderWall = (function() {
    __extends(CoderWall, Service);
    function CoderWall() {
      CoderWall.__super__.constructor.apply(this, arguments);
    }
    CoderWall.prototype.url = function() {
      return 'http://coderwall.com/' + this.settings.username + '.json';
    };
    CoderWall.prototype.collect = function(result) {
      var badge, _i, _len, _ref, _results;
      _ref = result.data.badges;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        badge = _ref[_i];
        _results.push(this.data.push(badge));
      }
      return _results;
    };
    CoderWall.prototype.render = function() {
      return CoderWall.__super__.render.call(this, this.data, function(service, item, elements) {
        elements.link.attr('href', 'http://coderwall.com/' + service.settings.username).attr('target', '_blank').appendTo(elements.li);
        return service.create('img', {
          'alt': item.name,
          'title': item.description,
          'src': item.badge
        }).appendTo(elements.link);
      });
    };
    return CoderWall;
  })();
  GitHub = (function() {
    __extends(GitHub, Service);
    function GitHub() {
      GitHub.__super__.constructor.apply(this, arguments);
    }
    GitHub.prototype.url = function() {
      return 'https://api.github.com/users/' + this.settings.username + '/repos';
    };
    GitHub.prototype.paginate = function(result) {
      if (result.meta && result.meta.Link && result.meta.Link[0][1]['rel'] !== 'first') {
        return result.meta.Link[0][0];
      } else {
        return false;
      }
    };
    GitHub.prototype.render = function() {
      var pushed_at, sorted_repos;
      pushed_at = new Date().setDate(new Date().getDate() - this.settings.pushed_at);
      sorted_repos = this.data.sort(function(a, b) {
        return new Date(b.pushed_at) - new Date(a.pushed_at);
      });
      return GitHub.__super__.render.call(this, sorted_repos, function(service, item, elements) {
        elements.link.attr('href', item.html_url).attr('target', '_blank').html(item.name).appendTo(elements.li);
        service.create('span', {
          'class': 'desc',
          'html': item.description
        }).appendTo(elements.li);
        if (service.settings.num_forks) {
            service.create('span',{
                'class': 'counters',
                'html': 'Forks: ' + item.forks
            }).appendTo(elements.li);
        }
        if (service.settings.num_watchers) {
            service.create('span',{
                'class': 'counters',
                'html': 'Watchers: ' + item.watchers
            }).appendTo(elements.li);
        }
        if (new Date(item.pushed_at) > pushed_at) {
          return service.create('span', {
            'class': 'status green',
            'html': service.settings.ongoing_status
          }).appendTo(elements.li);
        } else {
          return service.create('span', {
            'class': 'status red',
            'html': service.settings.onhold_status
          }).appendTo(elements.li);
        }
      });
    };
    return GitHub;
  })();
  $.fn.extend({
    proudify: function(options) {
      var VERSION, services, settings;
      VERSION = [0, 2, 0];
      services = {
        github: GitHub,
        coderwall: CoderWall
      };
      settings = $.extend({}, {
        username: false,
        service: 'github',
        pushed_at: 120,
        num: 0,
        forks: false,
        num_forks: true,
        num_watchers: true,
        loading_message: 'Loading ...',
        ongoing_status: 'ONGOING',
        onhold_status: 'ON HOLD'
      }, options || {});
      if (settings.username) new services[settings.service](this, settings);
      return this;
    }
  });
}).call(this);
