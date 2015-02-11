/* See LICENSE file for copyright and license details. */
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../utf.h"

int
fgetrune(Rune *p, FILE *fp)
{
	char buf[UTFmax];
	int i;

	for (i = 0; i < UTFmax && (buf[i] = fgetc(fp)) != EOF && ++i ;)
		if (charntorune(p, buf, i) > 0)
			break;
	if (ferror(fp))
		return -1;

	return i;
}

int
efgetrune(Rune *p, FILE *fp, const char *file)
{
	int ret;

	if ((ret = fgetrune(p, fp)) < 0) {
		fprintf(stderr, "fgetrune %s: %s\n", file, strerror(errno));
		exit(1);
	}
	return ret;
}
