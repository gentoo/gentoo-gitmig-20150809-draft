# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-0.6.4.ebuild,v 1.12 2004/07/14 23:35:02 agriffis Exp $

inherit eutils

DESCRIPTION="A C++ backend for glade, the GUI designer for Gtk."
HOMEPAGE="http://home.wtal.de/petig/Gtk/"
SRC_URI="http://distro.ibiblio.org/pub/linux/distributions/sorcerer/sources/${P}b.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="=dev-util/glade-0.6*
	=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*
	>=dev-cpp/gnomemm-1.2.0-r1"

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
		epatch ${FILESDIR}/glademm-0.6.4b-gcc3.patch
	fi

	# fixes gcc3 missing includes #40283
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc33_assert_fixes.patch

}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
	dodoc docs/*.txt docs/glade.wishlist
	dohtml -r docs
}
