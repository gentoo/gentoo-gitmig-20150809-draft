# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbapm/bbapm-0.0.1-r3.ebuild,v 1.6 2003/06/19 13:40:39 mkeadle Exp $

inherit eutils flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="blackbox advanced power management tool"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/contrib.phtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

replace-flags "-fomit-frame-pointer" ""

DEPEND="virtual/blackbox
	>=sys-apps/apmd-3.0.1"

src_unpack() {

	unpack ${A}; cd ${S}
	 sed -i -e 's:friend:friend class:' LinkedList.hh
	epatch ${FILESDIR}/${P}-gcc3.patch

}

src_compile() {

	./configure --prefix=/usr --host=${CHOST} || die
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
