# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.8.ebuild,v 1.2 2003/09/05 23:29:05 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox load monitor"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbsload"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="virtual/blackbox
		>=sys-devel/automake-1.7*"

RDEPEND="${DEPEND}"


src_compile() {
	econf || die
	# needs automake 1.7. breaks with emake.
	WANT_AUTOMAKE="1.7" make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbsload
}
