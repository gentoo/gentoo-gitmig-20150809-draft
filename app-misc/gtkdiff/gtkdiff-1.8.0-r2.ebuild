# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtkdiff/gtkdiff-1.8.0-r2.ebuild,v 1.7 2003/02/13 09:01:09 vapier Exp $

DESCRIPTION="GNOME Frontend for diff"
SRC_URI="http://www.ainet.or.jp/~inoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://www.ainet.or.jp/~inoue/software/gtkdiff/index-e.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	sys-apps/diffutils"
RDEPEND="nls? ( sys-devel/gettext
	dev-util/intltool )"

src_compile() {
	local myconf
	use nls || myconf=" --disable-nls"
	econf ${myconf}

	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
}
