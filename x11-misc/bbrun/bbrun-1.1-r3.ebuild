# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrun/bbrun-1.1-r3.ebuild,v 1.7 2002/08/02 17:54:50 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox program execution dialog box"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/contrib/${P}.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/contrib.phtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/blackbox
	=x11-libs/gtk+-1.2*"
RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	cd ${S}/bbrun
	mv Makefile Makefile.orig
	sed '/CFLAGS =/ s:$: -I/usr/include/gtk-1.2 -I/usr/include/glib-1.2 '"${CFLAGS}"':' Makefile.orig > Makefile
}

src_compile() {
	cd ${S}/bbrun
	emake || die
}

src_install () {
	into /usr
	dobin bbrun/bbrun
	dodoc README COPYING
}

pkg_postinst() {
	cd ${ROOT}usr/bin/wm
	if [ ! "`grep bbrun blackbox`" ] ; then
	sed -e "s/.*blackbox/exec \/usr\/bin\/bbrun \&\n&/" blackbox | cat > blackbox
	fi
}
