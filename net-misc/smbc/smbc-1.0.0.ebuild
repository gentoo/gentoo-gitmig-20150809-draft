# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smbc/smbc-1.0.0.ebuild,v 1.2 2005/03/03 10:03:38 mglauche Exp $

DESCRIPTION="A text mode (ncurses) SMB network commander. Features: resume and UTF-8"
HOMEPAGE="http://smbc.airm.net/en/index.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/gcc
	>=net-fs/samba-2.8.8
	sys-libs/ncurses
	dev-libs/popt"

src_install() {
	make DESTDIR=${D} install || die
}
