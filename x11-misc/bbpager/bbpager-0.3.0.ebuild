# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Gontran Zepeda <gontran@gontran.net>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.3.0.ebuild,v 1.1 2001/08/30 23:44:43 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An understated pager for Blackbox."
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbpager"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {
	./configure --prefix=/usr/X11R6 --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO NEWS ChangeLog
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	sed -e "s/.*blackbox/exec \/usr\/X11R6\/bin\/bbpager \&\n&/" blackbox | cat > blackbox
}
