# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbsload/bbsload-0.2.5-r1.ebuild,v 1.5 2002/08/01 11:59:04 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox load monitor"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbsload"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbsload
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	if [ ! "`grep bbsload blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/bin\/bbsload \&\n&/" blackbox | cat > blackbox
	fi
}
