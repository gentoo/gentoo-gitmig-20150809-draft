# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.6-r2.ebuild,v 1.7 2004/02/22 17:40:27 agriffis Exp $

DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="mirror://sourceforge/gwcc/${P}.tar.gz"
HOMEPAGE="http://gwcc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

RDEPEND="nls? ( sys-devel/gettext )
	sys-apps/net-tools"

src_compile() {
	local myconf

	#sandbox fix, always disable nls
	myconf="--disable-nls"
	#use nls || myconf="--disable-nls"

	econf ${myconf}
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog NEWS README
}
