# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbtime/bbtime-0.1.5.ebuild,v 1.8 2006/12/07 02:28:31 flameeyes Exp $

DESCRIPTION="blackbox time watcher"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbtime"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"
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
