# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.3.1.ebuild,v 1.2 2003/02/13 17:08:44 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An understated pager for Blackbox."
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbpager"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/blackbox"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README TODO NEWS ChangeLog
}

pkg_postinst() {
	if [ "`use gnome`" ] ; then
		cd ${ROOT}usr/X11R6/bin/wm
		if [ ! "`grep bbpager blackbox`" ] ; then
		sed -e "s:.*blackbox:exec /usr/bin/bbpager \&\n&:" \
			blackbox | cat > blackbox
		fi
	fi
}
