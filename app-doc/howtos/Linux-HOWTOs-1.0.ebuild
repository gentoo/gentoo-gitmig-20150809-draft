# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>

P="Linux-HOWTOs"
S=${WORKDIR}/${P}

DESCRIPTION="The Complete Linux Howto's from LDP. This is plain text format."

SRC_URI="http://www.ibiblio.org/pub/Linux/docs/HOWTO/${P}.tar.gz"

HOMEPAGE="http://www.linuxdoc.org"

#DEPEND=""

#RDEPEND=""


src_install () {
	dodir /usr/share/doc/howto
	dodir /usr/share/doc/howto/plain
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO
	mv ${WORKDIR}/* ${D}/usr/share/doc/howto/plain/
	echo -e "\033[1;42m\033[1;33m This ebuild doesn't need updates as it fetches the latest tar ball whenever installed. Emerge this package once in a month to get the latest HOWTOs. \033[0m"
}

