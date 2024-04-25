package language.fr;

import java.util.Optional;

import net.fellbaum.jemoji.Emoji;
import net.fellbaum.jemoji.EmojiManager;

public class Bonjour {
    public static void main() {
        Optional<Emoji> optionalEmoji = EmojiManager.getByAlias("fr");
        String emoji = optionalEmoji.map(value -> STR." \{value.getEmoji()}").orElse("");
        System.out.println(STR."Bonjour\{emoji}");
    }
}