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
		currentYear: if (new Date).getFullYear() == 2019 then '2019' else '2019-' + (new Date).getFullYear())

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
