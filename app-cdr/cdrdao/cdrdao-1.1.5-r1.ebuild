# Copyright 1999 - 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.1.5-r1.ebuild,v 1.14 2002/08/27 20:08:11 spider Exp $

S=${WORKDIR}/cdrdao-1.1.5
DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.src.tar.gz"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
RDEPEND="gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 
	<x11-libs/gtkmm-1.3.0
	>=gnome-extra/gnomemm-1.1.17 )"

DEPEND=">=dev-util/pccts-1.33.24-r1
	${RDEPEND}"

KEYWORDS="x86 ppc"

src_unpack() {

	unpack ${A}
	
	patch -p0 <${FILESDIR}/${P}-c++.patch || die

	if [ ! "`use gnome`" ] ; then
		patch -p0 <${FILESDIR}/${P}-gentoo.diff || die
	fi
}

src_compile() {

	local mygnome=""
# Gtk version is broken :(
#	if [ "`use gnome`" ] ; then
#		mygnome=" --with-gnome"
#		CFLAGS="${CFLAGS} `/usr/bin/gtkmm-config --cflags`"
#		CXXFLAGS="${CXXFLAGS} `/usr/bin/gtkmm-config --cflags` -fno-exceptions"
#		
#	fi

	# -funroll-loops do not work
	CFLAGS="${CFLAGS/-funroll-loops}"
	./configure "${mygnome}" \
		--prefix=/usr \
		--build="${CHOST}"\
		--host="${CHOST}"
		
	emake || die
}

src_install() {

	# cdrdao gets definitely installed
	# binary
	dobin dao/cdrdao
	
	# data of cdrdao in /usr/share/cdrdao/
	# (right now only driverlist)
	insinto /usr/share/cdrdao
	newins dao/cdrdao.drivers drivers
	
	# man page
	into /usr
	newman dao/cdrdao.man cdrdao.1
	
	# documentation
	docinto ""
	dodoc COPYING CREDITS INSTALL README* Release*
	
	 
	# and now the optional GNOME frontend
#	if [ "`use gnome`" ]
#	then
#
#		# binary
#		into /usr
#		dobin xdao/gcdmaster
#		
#		# pixmaps for gcdmaster in /usr/share/pixmaps/gcdmaster
#		insinto /usr/share/pixmaps/gcdmaster
#		doins xdao/pixmap_copycd.png 
#		doins xdao/pixmap_audiocd.png
#		doins xdao/pixmap_datacd.png
#		doins xdao/pixmap_open.png 
#		doins xdao/pixmap_mixedcd.png 
#		doins xdao/pixmap_cd.png
#		doins xdao/pixmap_help.png 
#		doins xdao/pixmap_dumpcd.png
#		doins xdao/gcdmaster.png
#		
#		# application links
#		# gcdmaster.desktop in /usr/share/gnome/apps/Applications
#		insinto /usr/share/gnome/apps/Applications
#		doins xdao/gcdmaster.desktop
#		
#		# xcdrdao.1 renamed to gcdmaster.1 in /usr/share/man/man1/
#		into /usr
#		newman xdao/xcdrdao.man gcdmaster.1
#	fi
}
