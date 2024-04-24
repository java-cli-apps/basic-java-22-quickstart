package language.en;

import java.util.Optional;

import net.fellbaum.jemoji.Emoji;
import net.fellbaum.jemoji.EmojiManager;

public class Hello {
    public static void main() {
        Optional<Emoji> optionalEmoji = EmojiManager.getByAlias("gb");
        String emoji = optionalEmoji.map(value -> STR." \{value.getEmoji()}").orElse("");
        System.out.println(STR."Hello \{emoji}");
    }
}