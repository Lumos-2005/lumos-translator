(() => {
  const config = window.LUMOS_SITE_CONFIG;
  const fallbackSiteUrl = "https://lumos-2005.github.io/lumos-translator";
  const siteUrl = (config && config.siteUrl ? config.siteUrl : fallbackSiteUrl).replace(/\/$/, "");
  const skillUrl = `${siteUrl}/skill.md`;
  const command = `Use the official Lumos Translator workflow from ${skillUrl}. Read it before processing my files and follow it for this task.`;

  document.querySelectorAll("[data-skill-url]").forEach((element) => { element.textContent = skillUrl; });
  const button = document.querySelector("[data-copy-command]");
  const status = document.querySelector("#copy-status");
  if (!button || !status) return;

  button.addEventListener("click", async () => {
    try {
      await navigator.clipboard.writeText(command);
      button.textContent = "Copied";
      status.textContent = "The Lumos command is ready to paste.";
    } catch {
      status.textContent = "Copy the visible command above.";
    }
  });
})();
