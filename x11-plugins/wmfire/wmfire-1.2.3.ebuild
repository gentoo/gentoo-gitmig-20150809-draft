# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfire/wmfire-1.2.3.ebuild,v 1.1 2008/01/12 11:39:27 drac Exp $

inherit eutils

DESCRIPTION="Load monitoring dockapp displaying dancing flame."
HOMEPAGE="http://www.swanson.ukfsn.org/#wmfire"
SRC_URI="http://www.swanson.ukfsn.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgtop-2
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-stringh.patch
}

src_compile() {
	econf --enable-session
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ALL_I_GET_IS_A_GREY_BOX AUTHORS ChangeLog NEWS README
}
