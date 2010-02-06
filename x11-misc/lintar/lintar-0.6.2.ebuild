# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lintar/lintar-0.6.2.ebuild,v 1.4 2010/02/06 20:11:57 ssuominen Exp $

EAPI=2
WANT_AUTOMAKE=1.9
inherit autotools eutils

DESCRIPTION="A decompressing tool written in GTK+."
HOMEPAGE="http://lintar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README NEWS TODO
}
