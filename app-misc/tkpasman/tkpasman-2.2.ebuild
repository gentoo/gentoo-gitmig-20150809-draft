# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tkpasman/tkpasman-2.2.ebuild,v 1.9 2006/02/09 21:25:46 ticho Exp $

MY_P="TkPasMan-${PV}"

DESCRIPTION="A useful and reliable personal password manager, written in Tcl/Tk"
HOMEPAGE="http://www.xs4all.nl/~wbsoft/linux/projects/"
SRC_URI="http://www.xs4all.nl/~wbsoft/linux/projects/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

DEPEND=">=dev-lang/tcl-8.3"
RDEPEND="ssl? ( dev-libs/openssl )
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3"

S=${WORKDIR}/${MY_P}

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
	dobin tkpasman || die
	dodoc README ChangeLog TODO WARNING INSTALL
}
