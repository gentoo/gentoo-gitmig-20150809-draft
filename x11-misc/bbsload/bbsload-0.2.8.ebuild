# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.8.ebuild,v 1.11 2006/12/03 10:58:49 omp Exp $

DESCRIPTION="blackbox load monitor"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbsload"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

RDEPEND="virtual/blackbox"
DEPEND="${RDEPEND}
	=sys-devel/automake-1.7*"

src_compile() {
	econf || die
	# needs automake 1.7. breaks with emake.
	WANT_AUTOMAKE="1.7" make || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbsload
}
