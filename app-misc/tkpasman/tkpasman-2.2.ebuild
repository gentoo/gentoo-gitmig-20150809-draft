# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tkpasman/tkpasman-2.2.ebuild,v 1.1 2003/05/04 19:24:52 aliz Exp $

MY_P="TkPasMan-${PV}"

SRC_URI="http://www.xs4all.nl/~wbsoft/linux/projects/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}/${MY_P}

IUSE="ssl"

DEPEND=">=dev-lang/tcl-8.3"

RDEPEND="ssl? ( dev-libs/openssl )
	virtual/x11
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3"

src_unpack() {
	unpack ${A}
	cd ${S}	

	cp config config.old
	use ssl || sed "s:^USE_OPENSSL=true:USE_OPENSSL=false:g" config.old >config
}

src_compile() {
	make || die
}

src_install() {
	dobin tkpasman
	dodoc README ChangeLog TODO WARNING INSTALL COPYING
}

