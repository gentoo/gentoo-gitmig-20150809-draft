# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.6-r2.ebuild,v 1.2 2002/11/30 01:25:58 vapier Exp $

DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gwcc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
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
