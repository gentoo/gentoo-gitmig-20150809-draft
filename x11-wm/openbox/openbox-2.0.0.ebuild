# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-2.0.0.ebuild,v 1.2 2002/09/03 10:48:03 seemant Exp $

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="ftp://sunsite.dk/projects/openbox/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

SLOT="2"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64"

MYBIN="${PN}"
mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"

src_unpack() {

	unpack ${A}
	cd ${S}

	cp Makefile.am Makefile.am.orig
	sed 's/data //' Makefile.am.orig > Makefile.am

	cd ${S}/util
	cp Makefile.am Makefile.am.orig
	sed -e 's/bsetbg//' \
		-e 's/bsetroot//' \
		Makefile.am.orig > Makefile.am
}



src_compile() {

	${S}/bootstrap

	commonise=""
	commonbox_src_compile
}

src_install() {

	commonbox_src_install
	mv ${D}/usr/bin/openbox ${D}/usr/bin/openbox-dev
	mv ${D}/usr/share/man/man1/openbox.1.gz \
		{D}/usr/share/man/man1/openbox-dev.1.gz

}
