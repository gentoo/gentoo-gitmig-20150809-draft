# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mtools/mtools-3.9.8-r1.ebuild,v 1.19 2003/05/01 21:13:50 agriffis Exp $

DESCRIPTION="utilities to access MS-DOS disks from Unix without mounting them"
SRC_URI="http://mtools.linux.lu/mtools-3.9.8.tar.gz"
HOMEPAGE="http://mtools.linux.lu/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="sys-apps/texinfo"

src_compile() {
	econf --sysconfdir=/etc/mtools
	make || die
}

src_install() {
	einstall sysconfdir=${D}/etc/mtools
	insinto /etc/mtools
	newins mtools.conf mtools.conf.example
	dodoc COPYING ChangeLog NEWPARAMS README* Release.notes 
}
