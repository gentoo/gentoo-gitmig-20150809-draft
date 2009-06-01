# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glurp/glurp-0.11.6-r2.ebuild,v 1.2 2009/06/01 19:45:44 ssuominen Exp $

EAPI=2
inherit autotools eutils flag-o-matic

DESCRIPTION="Glurp is a GTK2 based graphical client for the Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/glurp/"
SRC_URI="mirror://sourceforge/glurp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2:2
	>=gnome-base/libglade-2
	>=media-libs/libmpd-0.17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-system_libmpd.patch
	rm -f src/libmpdclient.*
	eautoreconf
}

src_configure() {
	append-flags -I/usr/include/libmpd-1.0/libmpd
	econf \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry glurp Glurp glurp AudioVideo
}
