# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/livecd-ng/livecd-ng-1.0.ebuild,v 1.8 2005/01/01 11:08:15 eradicator Exp $

DESCRIPTION="Gentoo LiveCD creation script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc"
IUSE=""

DEPEND=""

# Note for ppc users: You can build a ppc livecd with gentoo-src/pvdabeel/ppclivecd

src_install() {
	dodir /etc/livecd-ng
	cp -r profiles ${D}/etc/livecd-ng

	exeinto /usr/sbin
	doexe livecd-ng

	dodoc README
}
