# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbppp/bbppp-0.2.2-r1.ebuild,v 1.12 2004/07/15 00:51:03 agriffis Exp $

DESCRIPTION="blackbox ppp frontend/monitor"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbppp"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbppp
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	if [ ! "`grep bbppp blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/bin\/bbppp \&\n&/" blackbox | cat > blackbox
	fi
}
