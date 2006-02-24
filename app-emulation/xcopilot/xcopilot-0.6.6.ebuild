# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xcopilot/xcopilot-0.6.6.ebuild,v 1.7 2006/02/24 22:45:54 vanquirius Exp $

MY_P="xcopilot-0.6.6-uc0"

DESCRIPTION="A pilot emulator"
HOMEPAGE="http://www.uclinux.org/"
SRC_URI="http://www.uclinux.org/pub/uClinux/utilities/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="|| ( (	x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXt
		x11-libs/libXpm
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXdmcp )
		virtual/x11 )"

DEPEND="app-arch/dpkg
	|| ( ( x11-proto/xextproto
		x11-proto/xproto )
		virtual/x11 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --disable-autorun || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README NEWS README.uClinux
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/README.uClinux for more info"
}
