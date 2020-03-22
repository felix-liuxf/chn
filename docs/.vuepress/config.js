module.exports = {
    title: 'Some of my notes',
    description: 'Hello, VuePress!',
    head: [
        ['link', {
            rel: 'icon',
            href: `/favicon.ico`
        }]
    ],
    dest: './docs/.vuepress/dist',
    ga: '',
    evergreen: true,
    sidebarDepth:4,
    plugins: {
        "vuepress-plugin-auto-sidebar": {}
    },
    themeConfig: {
        lastUpdated: '上次更新',
        nav: [
            { text: 'Linux', link: '/linux/' },
            { text: 'Shell', link: '/shell/' },
            { text: 'open-source', link: '/open-source/' },
            { text: 'Mac', link: '/mac/' },
            { text: 'Oracle', link: '/oracle/' },
            { text: 'OCI', link: '/oci/' },
            { text: 'Spring', link: '/spring/' },
            { text: 'More', link: '/more/' },
        ],
    },
}
