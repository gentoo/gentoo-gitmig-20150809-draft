# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/livecd-ng/livecd-ng-1.0.ebuild,v 1.1 2003/02/01 00:48:36 chadh Exp $

DESCRIPTION="Gentoo LiveCD creation script" 
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}

src_install() {
	dodir /etc/livecd-ng
	cp -r profiles ${D}/etc/livecd-ng

	exeinto /usr/sbin
	doexe livecd-ng

	dodoc README
}
