# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdiff/gtkdiff-1.8.0-r2.ebuild,v 1.2 2004/02/06 04:21:25 agriffis Exp $

DESCRIPTION="GNOME Frontend for diff"
SRC_URI="http://home.catv.ne.jp/pp/ginoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://home.catv.ne.jp/pp/ginoue/software/gtkdiff/index-e.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	sys-apps/diffutils"
RDEPEND="nls? ( sys-devel/gettext
	dev-util/intltool )"

src_compile() {
	econf `use_enable nls`
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
