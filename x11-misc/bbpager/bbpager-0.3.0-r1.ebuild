# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Gontran Zepeda <gontran@gontran.net>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.3.0-r1.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An understated pager for Blackbox."
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbpager"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO NEWS ChangeLog
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	if [ ! "`grep bbpager blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/bin\/bbpager \&\n&/" blackbox | cat > blackbox
	fi
}
