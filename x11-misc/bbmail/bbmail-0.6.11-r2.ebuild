# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbmail/bbmail-0.6.11-r2.ebuild,v 1.6 2002/08/14 23:44:14 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox mail notification, patched for maildir"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/available.phtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/blackbox"

src_unpack () {
	unpack ${A}
	cd ${S}
	# This is a patch for bbmail to support qmail style maildirs
	patch -p1 < ${FILESDIR}/bbmail-qmail.patch || die
}

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO data/README.bbmail
}

pkg_postinst() {
	cd ${ROOT}usr/X11R6/bin/wm
	if [ ! "`grep bbmail blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/bin\/bbmail \&\n&/" blackbox | cat > blackbox
	fi
}
