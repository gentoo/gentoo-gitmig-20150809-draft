# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tkpasman/tkpasman-2.2a.ebuild,v 1.2 2003/09/05 12:10:36 msterret Exp $

MY_P="TkPasMan-${PV}"

SRC_URI="http://www.xs4all.nl/~wbsoft/linux/projects/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A useful and reliable personal password manager, written in Tcl/Tk"
SLOT="0"
IUSE="ssl"

DEPEND=">=dev-lang/tcl-8.3
	>=sys-apps/sed-4"

RDEPEND="ssl? ( dev-libs/openssl )
	virtual/x11
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3"

src_unpack() {
	unpack ${A} ; cd ${S}

	use ssl || sed -i "s:^USE_OPENSSL=true:USE_OPENSSL=false:g" config
}

src_compile() {
	make || die
}

src_install() {
	dobin tkpasman
	dodoc README ChangeLog TODO WARNING INSTALL COPYING
}

