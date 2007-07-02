# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k-gtk-gui/ed2k-gtk-gui-0.6.4.ebuild,v 1.4 2007/07/02 15:07:58 peper Exp $

DESCRIPTION="GTK+ Client for overnet or edonkey"
HOMEPAGE="http://ed2k-gtk-gui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=net-libs/gnet-1.1
	dev-util/pkgconfig"

src_compile() {
	econf || die "econf failed"
	sed -i -e "s:-DG_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED::g" ed2k_gui/Makefile
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	echo
	einfo "Please refer to ${HOMEPAGE} if you are"
	einfo "unable to set up the client."
	echo
	ewarn "ed2k-gtk-gui requires access to an overnet/edonkey core. If you"
	ewarn "do not have access to a core, you can install net-p2p/(overnet,edonkey)."
	echo
}
