package language.en;

import java.util.Optional;

import net.fellbaum.jemoji.Emoji;
import net.fellbaum.jemoji.EmojiManager;

public class Hello {
    public static void main() {
        Optional<Emoji> optionalEmoji = EmojiManager.getByAlias("gb");
        String drapeau = optionalEmoji.map((Emoji emoji) -> emoji.getEmoji()).orElse("");
        System.out.println("Hello " + drapeau);
    }
}