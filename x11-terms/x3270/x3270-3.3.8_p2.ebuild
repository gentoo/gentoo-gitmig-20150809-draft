# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/x3270/x3270-3.3.8_p2.ebuild,v 1.1 2009/01/02 09:50:37 vapier Exp $

inherit font

MY_P="${P/_}"
DESCRIPTION="IBM 3270 terminal emulator for the X Window System"
HOMEPAGE="http://x3270.bgp.nu/"
SRC_URI="mirror://sourceforge/x3270/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl )
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libSM
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake"

S=${WORKDIR}/${PN}-${PV:0:3}

src_compile() {
	econf \
		$(use_enable ssl) \
		--with-fontdir="${FONTDIR}" \
		|| die
	emake || die
}

src_install() {
	dodir "${FONTDIR}"
	emake DESTDIR="${D}" install install.man || die
	font_src_install
	chmod a-x "${D}"/usr/share/man/*/*
	dodoc README*
}
