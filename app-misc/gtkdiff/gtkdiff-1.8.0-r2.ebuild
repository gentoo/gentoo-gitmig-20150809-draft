# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtkdiff/gtkdiff-1.8.0-r2.ebuild,v 1.3 2002/07/25 17:20:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Frontend for diff"
SRC_URI="http://www.ainet.or.jp/~inoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://www.ainet.or.jp/~inoue/software/gtkdiff/index-e.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	sys-apps/diffutils"

RDEPEND="nls? ( sys-devel/gettext
	dev-util/intltool )"

src_compile() {
	local myconf

	use nls || myconf=" --disable-nls"
	econf ${myconf} || die

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
}
