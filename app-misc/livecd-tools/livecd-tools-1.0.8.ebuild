# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.8.ebuild,v 1.2 2004/10/22 15:20:27 wolf31o2 Exp $

IUSE="opengl X"

DESCRIPTION="LiveCD tools (autoconfig, net-setup)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/livecd-tools/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc amd64 ppc ~hppa"

DEPEND=""

src_install() {
	exeinto /etc/init.d && doexe autoconfig && newexe spind.init spind
	use X && dosbin x-setup
	# The following is commented because of bug #51726.
	#use opengl && dosbin opengl-update openglify
	dosbin net-setup spind
}
