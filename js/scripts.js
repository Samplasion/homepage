Vue.component('repo-item', {
    // The todo-item component now accepts a
    // "prop", which is like a custom attribute.
    // This prop is called todo.
    props: ['repo'],
    template: `
    <a class="panel-block is-active" v-bind:href="repo.href">
        <span class="panel-icon">
            <i class="fas" v-bind:class="repo.type" aria-hidden="true"></i>
        </span>
        <span class="text">{{ repo.name }}</span>
    </a>
    `
})

Vue.component('lang-progress', {
    // The todo-item component now accepts a
    // "prop", which is like a custom attribute.
    // This prop is called todo.
    props: ['lang'],
    template: `<div class="panel-block" style="width:100%">
    <p style="width:80%" data-value="80">{{lang.name}}</p>
    <progress class="progress is-primary" max="100" :value="lang.value"></progress></div>`
})

var app = new Vue({
    el: "#app",
    data: {
        search: "",
        repoList: [
            {
                name: "yamamura-discord-bot",
                href: "https://gitlab.com/yamamura1/yamamura-discord-bot",
                type: "fa-book"
            },
            {
                name: "repo",
                href: "https://github.com/Samplasion/repo",
                type: "fa-book"
            },
            {
                name: "list-array",
                href: "https://github.com/Samplasion/list-array",
                type: "fa-book"
            },
            {
                name: "7heaven",
                href: "https://github.com/Samplasion/7heaven",
                type: "fa-book"
            },
            {
                name: "jacobjordan94/mario-maker",
                href: "https://github.com/jacobjordan94/mario-maker",
                type: "fa-code-branch"
            },
        ],
        langList: [
            {
                name: "JavaScript",
                value: 80
            },
            {
                name: "Objective-C",
                value: 25
            },
            {
                name: "Swift",
                value: 26
            },
            {
                name: "Python",
                value: 15
            },
            {
                name: "PHP",
                value: 2
            },
            {
                name: "Ruby",
                value: 5
            }
        ].sort((a, b) => b.value - a.value)
    }
})

document.querySelector("#reposearch").onkeyup = function () {
    console.log(1)
    var self = this;
    Array.from(document.querySelectorAll(".repo").values()).forEach(el => {
        console.log(el)
        if (el.innerText.includes(self.value))
            el.style = `display: block`
        else
            el.style = `display: none`
    })
}

var app2 = new Vue({
    el: "#app2",
    data: {
        currentYear: new Date().getFullYear() == 2019 ? "2019" : "2019-" + new Date().getFullYear()
    }
})

var n = (Math.random());
console.log(n);
if (n < 0.33)
    document.querySelector("#avatar-icon").classList.add("bump")
else if (n < 0.66)
    document.querySelector("#avatar-icon").classList.add("ondulate")
else
    document.querySelector("#avatar-icon").classList.add("both")
