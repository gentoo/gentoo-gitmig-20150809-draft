# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tla/tla-1.0.6.ebuild,v 1.3 2004/01/12 18:02:45 rphillips Exp $

DESCRIPTION="the arch revision control system (C-implementation)"
HOMEPAGE="http://regexps.srparish.net/www/"
SRC_URI="http://regexps.srparish.net/src/tla/tla-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	# recommended install settings
	cd src ; mkdir \=build ; cd \=build
	../configure --prefix=/usr
	make
}

src_install() {
	cd src ; cd \=build
	einstall || die

	dodoc \=INSTALL \=COPYING
}
