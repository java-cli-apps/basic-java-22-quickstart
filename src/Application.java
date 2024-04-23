///usr/bin/env java --source 22 --enable-preview --class-path ${APP_DIR:-.}/lib/'*' "$0" "$@"; exit $?

class Main {
    void main() {
        switch (Language.guess()) {
            case French -> fr.Hello.main();
            case English -> en.Hello.main();
        }
        System.exit(0);
    }

    private enum Language {
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
}
