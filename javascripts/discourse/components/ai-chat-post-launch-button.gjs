import Component from "@glimmer/component";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import { i18n } from "discourse-i18n";

export default class AiChatPostLaunchButton extends Component {

  @action
  async launchChat() {
    const postContents = await this.fetchRawPost(this.args.post.id);

    if (!postContents) {
      return;
    }

    const URL = `${settings.ai_chat_post_launch_service_base_url}${encodeURIComponent(postContents)}`;

    window.open(URL, "_blank");
  }

  async fetchRawPost(postId) {
    try {
      const { raw } = await ajax(`/posts/${postId}.json`);
      return raw;
    } catch (error) {
      popupAjaxError(error);
    }
  }

  get launchIcon() {
    return settings.ai_chat_post_launch_icons;
  }

  <template>
    <DButton
      class="post-action-menu__ai-chat-post-launch-button"
      ...attributes
      @action={{this.launchChat}}
      @icon={{this.launchIcon}}
      title={{i18n (themePrefix "ai_chat_launch.title")}}
    />
  </template>
}
