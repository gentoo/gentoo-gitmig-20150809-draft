# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gwcc/gwcc-0.9.6-r1.ebuild,v 1.9 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Workstation Command Center"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gwcc.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

RDEPEND="nls? ( sys-devel/gettext )
	sys-apps/net-tools"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog NEWS README 
}
