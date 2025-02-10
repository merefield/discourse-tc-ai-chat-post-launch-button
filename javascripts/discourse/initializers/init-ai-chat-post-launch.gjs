import { withPluginApi } from "discourse/lib/plugin-api";
import AiChatPostLaunchButton from "./../components/ai-chat-post-launch-button";

export default {
  name: "ai-chat-post-launch-button",

  initialize(container) {
    let currentUser = container.lookup("service:currentUser");
    if (!settings.open_post_in_llm_chat_enabled_for_anon && !currentUser) {
      return;
    }

    withPluginApi("1.34.0", (api) => {
      api.registerValueTransformer("post-menu-buttons", ({ value: dag }) => {
        dag.add("ai-chat-post-launch-button", AiChatPostLaunchButton);
      });
    });
  },
};
