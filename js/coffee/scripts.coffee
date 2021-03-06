Vue.component 'repo-item',
	props: [ 'repo' ]
	template: '''
	          <a class="panel-block is-active" v-bind:href="repo.href">
	            <span class="panel-icon">
	                <i class="fas" v-bind:class="repo.type" aria-hidden="true"></i>
	            </span>
	            <span class="text">{{ repo.name }}</span>
	          </a>'''

Vue.component 'lang-progress',
	props: [ 'lang' ]
	template: '''
    <div class="panel-block" style="width:100%">
        <p style="width:80%" data-value="80">{{lang.name}}</p>
        <progress class="progress is-primary" max="100" :value="lang.value">{{lang.value}}%</progress>
    </div>'''

app = new Vue(
	el: '#app'
	data:
		search: ''
		repoList: [
			{
				name: 'yamamura1/yamamura-discord-bot'
				href: 'https://gitlab.com/yamamura1/yamamura-discord-bot'
				type: 'fa-code-branch'
			}
			{
				name: 'jacobjordan94/mario-maker'
				href: 'https://github.com/jacobjordan94/mario-maker'
				type: 'fa-code-branch'
			}
		]
		langList: [
			{
				name: 'JavaScript'
				value: 80
			}
			{
				name: 'Objective-C'
				value: 25
			}
			{
				name: 'Swift'
				value: 26
			}
			{
				name: 'Python'
				value: 15
			}
			{
				name: 'PHP'
				value: 2
			}
			{
				name: 'Ruby'
				value: 5
			}
			{
				name: 'Shell'
				value: 2
			}
		].sort((a, b) ->
			b.value - (a.value)
		)
		currentYear: if (new Date).getFullYear() == 2019 then '2019' else '2019-' + (new Date).getFullYear()
		projects: window.projects
)

Vue.component 'project-list',
	template: '''
<div>
	<section class="section" v-for="project in projects">
		<div class="container">
			<h2 class="subtitle is-size-3" :id="project.id + 'Project'">{{project.name}}</h2>
			<template v-if="projects.indexOf(project) % 2 == 0">
				<div class="columns">
					<div class="column">
						<span class="subtitle" v-html="project.description"></span>
					</div>
					<div class="column" noclass="incline incline-cw">
						<article class="panel is-primary">
							<p class="panel-heading">
								Screenshots
							</p>
							<image-carousel v-bind:index="0" v-bind:set="{photos: project.photos, id: project.id}" />
						</article>
					</div>
				</div>
			</template>
			<template v-else>
				<div class="columns mobile-reverse">
					<div class="column" noclass="incline incline-ccw">
						<article class="panel is-primary">
							<p class="panel-heading">
								{{project.name}}
							</p>
							<image-carousel v-bind:index="0" v-bind:set="{photos: project.photos, id: project.id}" />
						</article>
					</div>
					<div class="column">
						<span class="subtitle" v-html="project.description"></span>
					</div>
				</div>
			</template>
		</div>
	</section>
</div>
	'''
	computed:
		projects: -> app.projects

images_looped = false

Vue.component 'image-carousel',
	props: [
		'set', # the set of images to use
		'index'
	] #
	template: '''
	<div class="panel-block">
		<div class="slider" :id="set.id">
			<div class="slider-container">
				<div class="slide-item" v-for="image in arr">
					<img v-bind:src="image" class="outer-image" :data-target="'#' + image.split('.')[0].split('/')[2]" />
					<div class="modal" :id="image.split('.')[0].split('/')[2]">
						<div class="modal-background"></div>
						<div class="modal-content">
							<p class="image">
							<img :src="image" :alt="'Screenshot ' + (arr.indexOf(image)+1)">
							</p>
						</div>
						<button class="modal-close is-large" aria-label="close"></button>
					</div>
				</div>
			</div>
		</div>

        <!--img v-bind:src="arr[index]"-->
    </div>
	'''
	computed:
		arr: ->
			set = this.set
			return set.photos.map((name) -> "images/" + set.id + "/" + name)
	mounted: ->
		console.log this.set.id;
		slider(
			selector: document.querySelector('#' + this.set.id)
			arrows: true
		)
		if (images_looped)
			return
		images = document.querySelectorAll '.outer-image'
		i = 0
		while i < images.length
			console.log(i, images[i]);
			image = images[i]
			image.addEventListener 'click', imgclick = (event) ->
				img = event.target
				event.preventDefault()
				modal = document.querySelector(img.getAttribute("data-target"))
				html = document.querySelector 'html'

				modal.classList.add 'is-active'
				html.classList.add 'is-clipped'
				
				modal.querySelector('.modal-background').addEventListener 'click', (e) ->
					e.preventDefault()
					modal.classList.remove 'is-active'
					html.classList.remove 'is-clipped'
					return
				return
			i++
		images_looped = true;
		###new Glide('.glide',
			type: 'carousel'
			#autoplay: 3000
		).mount()###
		###
		imgs = this.carousel.querySelectorAll('.carousel-cell img')
		# get transform property
		docStyle = document.documentElement.style
		transformProp = if `typeof docStyle.transform == 'string'` then 'transform' else 'WebkitTransform'
		flkty.on 'scroll', ->
			flkty.slides.forEach (slide, i) ->
				img = imgs[i]
				x = (slide.target + flkty.x) * -1 / 3
				img.style[transformProp] = 'translateX(' + x + 'px)'
				return
			return###

document.querySelector('#reposearch').onkeyup = ->
	console.log 1
	self = this
	Array.from(document.querySelectorAll('.repo').values()).forEach (el) ->
		console.log el
		if el.innerText.includes(self.value)
			el.style = 'display: flex'
		else
			el.style = 'display: none'
		return
	return

n = Math.random()
# console.log n
if n < 1 / 3
	document.querySelector('#avatar-icon').classList.add 'bump'
else if n < 2 / 3
	document.querySelector('#avatar-icon').classList.add 'ondulate'
else
	document.querySelector('#avatar-icon').classList.add 'both'

# Set up our HTTP request
xhr = new XMLHttpRequest
# Setup our listener to process completed requests

xhr.onload = ->
  # Process our return data
  if xhr.status >= 200 and xhr.status < 300
    # What do when the request is successful
    # console.log xhr
    data = JSON.parse xhr.response
    # console.log data
    app.repoList = data.map((repo) -> {name: repo.name, href: repo.html_url, desc: repo.description, type: "fa-book"}).sort((a, b) -> a.name.localeCompare b.name).concat app.repoList if Array.isArray data
    app.repoList = app.repoList.sort((a, b) ->
        a.name.localeCompare b.name
    )
  else
    # What do when the request fails
    # console.log 'The request failed!'
  # Code that should run regardless of the request status
  # console.log 'This always runs...'
  return

# Create and send a GET request
# The first argument is the post type (GET, POST, PUT, DELETE, etc.)
# The second argument is the endpoint URL
xhr.open 'GET', 'https://api.github.com/users/Samplasion/repos?per_page=100'
xhr.send()

# https://api.github.com/users/Samplasion/repos?per_page=100

Vue.config.devtools = true