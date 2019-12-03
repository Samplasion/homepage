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
				name: 'repo'
				href: 'https://github.com/Samplasion/repo'
				type: 'fa-book'
			}
			{
				name: 'list-array'
				href: 'https://github.com/Samplasion/list-array'
				type: 'fa-book'
			}
			{
				name: '7heaven'
				href: 'https://github.com/Samplasion/7heaven'
				type: 'fa-book'
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
