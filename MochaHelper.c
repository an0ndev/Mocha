#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

int main (int argc, char* argv[]) {
	if (argc != 2) {
		printf ("[MH] invalid number of arguments (expected 1)\n");
		return EXIT_FAILURE;
	}
	char pmsetLocation [] = "/usr/bin/pmset";
	char allPowerSourcesSpecifier [] = "-a";
	char settingKey [] = "disablesleep";
	
	char settingValue [2];
	if (strcmp (argv [1], "enable") == 0) {
		strcpy (settingValue, "1");
	} else if (strcmp (argv [1], "disable") == 0) {
		strcpy (settingValue, "0");
	} else {
		printf ("[MH] invalid argument \"%s\" (expected enable/disable)\n", argv [1]);
		return EXIT_FAILURE;
	}
	
	int ret;
	
	ret = execl (pmsetLocation, pmsetLocation, allPowerSourcesSpecifier, settingKey, settingValue, NULL);
	
	if (ret < 0) {
		printf ("[MH] execl returned error %s\n", strerror (errno));
		return EXIT_FAILURE;
	}
	// Code path is never reached since execl will not return on success
}
