# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-oh323/asterisk-oh323-0.6.5.ebuild,v 1.3 2005/07/10 01:07:04 swegener Exp $

inherit eutils flag-o-matic

IUSE="debug"

DESCRIPTION="H.323 Support for the Asterisk soft PBX"
HOMEPAGE="http://www.inaccessnetworks.com/projects/asterisk-oh323/"
SRC_URI="http://www.inaccessnetworks.com/projects/asterisk-oh323/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="~dev-libs/pwlib-1.6.6
	~net-libs/openh323-1.13.5
	>=net-misc/asterisk-1.0.0"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch

	# add -fPIC and use our own flags
	append-flags -fPIC

	sed -i  -e "s:^\(CPPFLAGS=\)\(.*\):\1 ${CXXFLAGS} \2:" \
		-e "s:^\(CFLAGS=\)\(.*\):\1 ${CFLAGS} \2:" \
		Makefile

	# disable wraptracing if you dont need it
	if ! use debug; then
		sed -i -e "s:^\(WRAPTRACING\).*:\1=0:" Makefile
	fi
}

src_compile() {
	# NOTRACE=1 is set in the Makefile
	# emake breaks version detection for pwlib and openh323
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
