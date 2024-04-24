///usr/bin/env java --source 22 --enable-preview --class-path ${APP_DIR:-.}/lib/'*' "$0" "$@"; exit $?

import static language.Language.*;

void main() {
    switch (guess()) {
        case French -> language.fr.Hello.main();
        case English -> language.en.Hello.main();
    }
    System.exit(0);
}
