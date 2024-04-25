///usr/bin/env java --source 22 --enable-preview --class-path ${APP_DIR:-.}/lib/'*' "$0" "$@"; exit $?

import language.Language;
import language.en.Hello;
import language.fr.Bonjour;

void main() {
    switch (Language.guess()) {
        case French -> Bonjour.main();
        case English -> Hello.main();
    }
    System.exit(0);
}
