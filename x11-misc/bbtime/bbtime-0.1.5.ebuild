# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbtime/bbtime-0.1.5.ebuild,v 1.6 2005/01/18 15:47:08 ka0ttic Exp $

DESCRIPTION="blackbox time watcher"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbsload"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/blackbox"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO

	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv ${D}/usr/share/bbtools/bbtoolsrc.in \
		${D}/usr/share/doc/${PF}/bbtoolsrc.example
}
