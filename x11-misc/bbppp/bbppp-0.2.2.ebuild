# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbppp/bbppp-0.2.2.ebuild,v 1.1 2001/08/31 01:52:26 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox ppp frontend/monitor"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbppp"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {
	./configure --prefix=/usr/X11R6 --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbppp
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	sed -e "s/.*blackbox/exec \/usr\/X11R6\/bin\/bbppp \&\n&/" blackbox | cat > blackbox
}
