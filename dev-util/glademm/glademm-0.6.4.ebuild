# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-0.6.4.ebuild,v 1.6 2003/04/26 21:26:29 liquidx Exp $

DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
HOMEPAGE="http://home.wtal.de/petig/Gtk/"
SRC_URI="http://distro.ibiblio.org/pub/linux/distributions/sorcerer/sources/${P}b.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="=dev-util/glade-0.6*
	=x11-libs/gtk+-1.2*
	=x11-libs/gtkmm-1.2*
	>=gnome-extra/gnomemm-1.2.0-r1"

S=${WORKDIR}/${P}b

src_unpack() {
	unpack ${A}

	#Fix to compile with gcc-3's C++ ABI
	if [ "`gcc --version | cut -f1 -d.`" == "3" ] ||
		([ -n "${CXX}" ] && [ "`${CXX} --version | cut -f1 -d.`" == "3" ]) ||
		[ "`gcc --version|grep gcc|cut -f1 -d.|cut -f3 -d\ `" == "3" ]
	then
		cd ${WORKDIR}
		# Fix supplied by "Nicholas Wourms" <nwourms@netscape.net> 
		patch -p0 < ${FILESDIR}/glademm-0.6.4b-gcc3.patch || die
	fi
}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc docs/*.txt docs/glade.wishlist
	dohtml -r docs
}
