# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.0_beta1.ebuild,v 1.2 2004/03/12 18:59:57 seemant Exp $

IUSE=""

DESCRIPTION="LiveCD tools (autoconfig, net-setup)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc hppa alpha"

DEPEND="virtual/glibc"

src_install() {
	exeinto /etc/init.d
	doexe autoconfig

	dosbin net-setup
}
