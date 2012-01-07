Proudify
========
Proudify is an awesome jQuery plugin to display your GitHub projects and Coderwall badges.

The GitHub projects part is a Javascript only implementation of [Chris Oliver](https://github.com/excid3)'s idea called
[Current Projects](http://currentprojects.heroku.com/), suitable for static web pages.

The CoderWall badges part is based on [Herman Junge](http://hermanjunge.com/)'s 
[idea](http://hermanjunge.com/post/6131651487/coderwall-badge-in-your-blog-d).

Click [here](http://proudify.me) to check it out in action!

Getting Started
---------------
You can either copy `jquery-proudify.min.js` and `proudify.min.css` or 
link to them in this repository.

The later is recommended because you will get instant updates and
bug fixes without the hassle of updating by yourself.

### Install

CSS (skin)

```html
<link rel="stylesheet" href="proudify.min.css" type="text/css"/>
```

The CSS above is optional and is only required if you do not want to create your own `theme`.

Javascript

```html
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
<script type="text/javascript" src="jquery-proudify.min.js"></script>
```
You'll also need a recent version of jQuery as seen above.

### Configure

Proudify takes a `hash` of options as described below:

* username - your *GitHub* or *Coderwall* username (**required**)
* service - *'github'* or *'coderwall'* (default: **github**)
* pushed_at - number of days after a repository is considered to be **ON HOLD** (default: **120 ~ 4 months**) 
* num - limit the number of shown repositories (default: **0 - show all**)
* forks - include forks beside your own *original* repositories (default: **false**)
* onhold_status - The text you wish to use for on hold project (defaults to **ON HOLD**)
* ongoing_status - The text you wish to use for ongoing projects (defaults to **ONGOING**)
* loading_message - The loading message you wish to use (defaults to **Loading...**)

The last six `options` are for *Github* **only**.

### Usage

```html
<div id="proudify"></div>
<script type="text/javascript">
  $('#proudify').proudify({'username':'icebreaker'});
</script>
```
You can style it at your heart's content, `proudify.css` is a good starting point
if you want to customize or tweak certain things.

TODO
----
These "features" are in the works and will be added soon :)

* pull and show other public Github user info
* show fork & watch count ( suggestion by [@amanelis](https://github.com/amanelis) )
* show public activity feed (with this generic RSS support as well)
* show tweets
* 'real time' preview, so anybody could try it before creating his own
* `proudify` gem (generate gh-pages, etc) for quick `setup`

Credits
-------
* initial CoffeeScript version by [EnriqueVidal](https://github.com/EnriqueVidal)

Contribute
----------
* Fork the project.
* Make your feature addition or bug fix in CoffeeScript files **not** JavaScript files.
* Do **not** bump the version number.
* Send me a pull request. Bonus points for topic branches.

#### Cakefile
```bash
cake build		# builds proudify (results in the `build` directory)
cake watch		# watches and builds proudify when changes detected (`src` directory)
cake release	# builds and minifies proudify (results in the `build` directory)
```

License
-------
Copyright (c) 2011, Mihail Szabolcs

Proudify is provided **as-is** under the **MIT** license. For more information see LICENSE.
