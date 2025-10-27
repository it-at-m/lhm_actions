import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "lhm-actions",
  description: "actions for the github workflow in the it-at-m organisation",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [{ text: "Home", link: "/" }],

    sidebar: [
      {
        text: "lhm-actions",
        items: [
          { text: "Actions", link: "/actions" },
          { text: "Deployment", link: "/deployment" },
          { text: "Workflows", link: "/workflows" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/it-at-m/lhm_actions" },
    ],
  },
});
