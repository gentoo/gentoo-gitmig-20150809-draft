# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbapm/bbapm-0.0.1.ebuild,v 1.2 2001/10/01 00:20:58 lordjoe Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox advanced power management tool"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/contrib.phtml"

DEPEND=">=x11-wm/blackbox-0.61
        >=sys-apps/apmd-3.0.1"

src_compile() {
	./configure --prefix=/usr/X11R6 --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	if [ ! "`grep bbapm blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/X11R6\/bin\/bbapm \&\n&/" blackbox | cat > blackbox
	fi
}
