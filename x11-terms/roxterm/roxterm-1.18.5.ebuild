# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/roxterm/roxterm-1.18.5.ebuild,v 1.1 2010/07/27 14:03:26 lack Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="A terminal emulator designed to integrate with the ROX environment"
HOMEPAGE="http://roxterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/roxterm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.6
		 >=x11-libs/gtk+-2.6
		 >=dev-libs/dbus-glib-0.71
		 >=x11-libs/vte-0.11.11
		 >=gnome-base/libglade-2"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.20"

src_prepare() {
	epatch "${FILESDIR}/${P}-docdir.patch"
	eautoreconf
}

src_configure() {
	econf --docdir="/usr/share/doc/${PF}"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
}
