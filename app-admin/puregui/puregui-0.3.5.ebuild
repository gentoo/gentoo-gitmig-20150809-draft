# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/puregui/puregui-0.3.5.ebuild,v 1.6 2002/07/17 20:43:17 drobbins Exp $



S=${WORKDIR}/${PN}
DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="mirror://sourceforge/pureftpd/${P}.tar.bz2"
SLOT="0"
HOMEPAGE="http://pureftpd.sourceforge.net"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	
	local myconf

	use nls \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf} || die

	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README

}
