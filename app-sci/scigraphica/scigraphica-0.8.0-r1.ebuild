# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/scigraphica/scigraphica-0.8.0-r1.ebuild,v 1.2 2003/04/27 10:56:23 tantive Exp $

DESCRIPTION="Scientific application for data analysis and technical graphics"
SRC_URI="http://scigraphica.sourceforge.net/src/${P}.tar.gz"
HOMEPAGE="http://scigraphica.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome"

DEPEND=">=x11-libs/gtk+extra-0.99.17
	>=dev-python/Numeric-20.3
	>=dev-libs/libxml-1.8.16
	>=media-libs/imlib-1.9.14
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r3 >=gnome-base/ORBit-0.5.12-r1 >=gnome-base/gnome-print-0.34 )"
	#bonobo? ( >=gnome-base/bonobo-1.0.18 )"
		
src_compile() {
	#bonobo breaks compile when enabled so it is not enabled for now.
	#the result seems to be no printing under gnome.
	#also need to look into --with-lp and --with-lpr config flags

	local myconf=""
	use gnome || myconf="${myconf} --without-gnome" #default enabled
#	use bonobo && myconf="${myconf} --with-bonobo" #default disabled

	#fix Exec= in sg.desktop
	cp sg.desktop sg.desktop.orig
	sed -e 's:\(Exec=\)sga:\1scigraphica:' sg.desktop.orig > sg.desktop

	#fix termcap dependency
	cp configure configure.orig
	sed -e 's:-ltermcap:-lncurses:' configure.orig > configure
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "Configuration Failed"
	
	emake || die "Parallel Make Failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation Failed"
	dodoc AUTHORS ChangeLog FAQ.compile \
		INSTALL NEWS README TODO
}
