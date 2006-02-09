# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tkpasman/tkpasman-2.2a.ebuild,v 1.13 2006/02/09 21:25:46 ticho Exp $

inherit eutils

MY_P="TkPasMan-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A useful and reliable personal password manager, written in Tcl/Tk"
HOMEPAGE="http://www.xs4all.nl/~wbsoft/linux/tkpasman.html"
SRC_URI="http://www.xs4all.nl/~wbsoft/linux/projects/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ssl"

DEPEND=">=dev-lang/tcl-8.3
	>=sys-apps/sed-4"

RDEPEND="ssl? ( dev-libs/openssl )
	>=dev-lang/tk-8.3
	>=dev-lang/tcl-8.3"

src_unpack() {
	unpack ${A} && cd "${S}"

	epatch ${FILESDIR}/${P}-gentoo.patch

	use ssl || sed -i "s:^USE_OPENSSL=true:USE_OPENSSL=false:g" config
}

src_compile() {
	make || die "compile failed"
}

src_install() {
	dobin tkpasman || die
	dodoc README ChangeLog TODO WARNING INSTALL
}
