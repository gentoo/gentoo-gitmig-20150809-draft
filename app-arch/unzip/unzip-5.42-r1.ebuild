# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.42-r1.ebuild,v 1.6 2002/07/25 14:47:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Unzipper for pkzip-compressed files"
SRC_URI="http://soft.ivanovo.ru/Linux/unzip542.tar.gz"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"

SLOT="0"
LICENSE="Info-ZIP"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_compile() {

	cp unix/Makefile unix/Makefile.orig
	sed -e "s:-O3:${CFLAGS}:" unix/Makefile.orig > unix/Makefile

	case $ARCH in
		i?.86)		TARGET=linux		;;
			*)		TARGET=linux_noasm	;;
	esac

	make -f unix/Makefile $TARGET || die

}

src_install() {

	dobin unzip funzip unzipsfx unix/zipgrep
	doman man/*.1
	dodoc BUGS COPYING History* LICENSE README ToDo WHERE


}
