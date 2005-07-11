# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbmail/bbmail-0.8.3.ebuild,v 1.7 2005/07/11 22:47:35 swegener Exp $

IUSE=""
DESCRIPTION="blackbox mail notification"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbmail"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"

DEPEND="virtual/blackbox"

src_install () {
	make DESTDIR="${D}" install || die
	dobin scripts/bbmailparsefm.pl
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
}
