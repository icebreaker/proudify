Proudify
========
Proudify is an awesome jQuery plugin to display your GitHub projects and Coderwall badges.

The GitHub projects part is a Javascript only implementation of [Chris Oliver](https://github.com/excid3)'s idea called
[Current Projects](http://currentprojects.heroku.com/), suitable for static web pages.

The CoderWall badges part is based on [Herman Junge](http://hermanjunge.com/)'s 
[idea](http://hermanjunge.com/post/6131651487/coderwall-badge-in-your-blog-d).

Click [here](http://status.szabster.net) to check it out in action.

Getting Started
---------------
You can either copy `jquery-proudify.min.js` and `proudify.min.css` or 
link to them in this repository.

The later is recommended because you will get instant updates and
bug fixes without the hassle of updating by yourself.

### Install

CSS (skin)

	<link rel="stylesheet" href="proudify.min.css" type="text/css"/>

The CSS above is optional and is only required if you do not want to create your own `theme`.

Javascript
	
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script type="text/javascript" src="jquery-proudify.min.js"></script>

You'll also need a recent version of jQuery as seen above.
	
### Configure

Proudify takes a `hash` of options as described below:

* username - your *GitHub* or *Coderwall* username (**required**)
* service - *'github'* or *'coderwall'* (default: **github**)
* pushed_at - number of days after a repository is considered to be **ON HOLD** (default: **120 ~ 4 months**) 
* num - limit the number of shown repositories (default: **0 - show all**)
* forks - include forks beside your own *original* repositories (default: **false**)

The last three `options` are for *Github* **only**.

### Usage

	<div id="proudify"></div>
	<script type="text/javascript">
		$('#proudify').proudify({'username':'icebreaker'});
	</script>
	
You can style it at your heart's content, `proudify.css` is a good starting point
if you want to customize or tweak certain things.
	
Contribute
----------
* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.
* Do **not** bump the version number.

License
-------
Copyright (c) 2011, Mihail Szabolcs

Templatizer is provided **as-is** under the **MIT** license. For more information see LICENSE.
