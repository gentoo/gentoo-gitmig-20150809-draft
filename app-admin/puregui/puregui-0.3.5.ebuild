# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <crux@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/puregui/puregui-0.3.5.ebuild,v 1.1 2002/04/27 03:56:59 seemant Exp $



S=${WORKDIR}/${PN}
DESCRIPTION="A GUI to Configure Pure-FTPD"
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/${P}.tar.bz2"
HOMEPAGE="http://pureftpd.sourceforge.net"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-1.2.10-r4"

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
