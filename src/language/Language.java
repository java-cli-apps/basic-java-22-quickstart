package language;

public enum Language {
    French, English;

    public static Language guess() {
        var langEnvVar = System.getenv("LANG");
        var langPrefix = langEnvVar.substring(0, langEnvVar.indexOf('_'));
        return switch (langPrefix) {
            case "fr" -> French;
            case "en" -> English;
            default -> throw new IllegalStateException(STR."Unexpected Language: \{langPrefix}");
        };
    }
}
