# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/livecd-ng/livecd-ng-1.0.ebuild,v 1.3 2003/02/13 05:25:51 vapier Exp $

DESCRIPTION="Gentoo LiveCD creation script" 
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc"
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
