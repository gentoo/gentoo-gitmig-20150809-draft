# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Peter Kadau <peter.kadau@web.de>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcdmaster/gcdmaster-1.1.5.ebuild,v 1.1 2001/08/08 09:43:54 hallski Exp $

A=cdrdao-1.1.5.src.tar.gz
S=${WORKDIR}/cdrdao-1.1.5
DESCRIPTION="Burn CDs in disk-at-once mode -- with GUI frontend"
SRC_URI="http://prdownloads.sourceforge.net/cdrdao/${A}"
HOMEPAGE="http://cdrdao.sourceforge.net/"

DEPEND=">=dev-util/pccts-1.33.24-r1
        >=gnome-base/gnome-libs-1.2.3
        >=x11-libs/gtkmm-1.2.5
        >=gnome-libs/gnomemm-1.1.17"

RDEPEND=">=gnome-base/gnome-libs-1.2.3
         >=x11-libs/gtkmm-1.2.5
         >=gnome-libs/gnomemm-1.1.17"

src_compile() {
	try ./configure --with-gnome --prefix=/usr --build="${CHOST}" \
	   --host="${CHOST}"

	try emake
}

src_install() {
	# binaries
	# cdrdao in /usr/bin
	dobin dao/cdrdao
	# gcdmaster in /opt/gnome/bin
	into /opt/gnome
	dobin xdao/gcdmaster
	#
	# data of cdrdao in /usr/share/cdrdao/
	# (right now only driverlist)
	insinto /usr/share/cdrdao
	newins dao/cdrdao.drivers drivers
	#
	# pixmaps for gcdmaster in /opt/gnome/share/pixmaps/gcdmaster
	insinto /opt/gnome/share/pixmaps/gcdmaster
	doins xdao/pixmap_copycd.png 
	doins xdao/pixmap_audiocd.png
	doins xdao/pixmap_datacd.png
	doins xdao/pixmap_open.png 
	doins xdao/pixmap_mixedcd.png 
	doins xdao/pixmap_cd.png
	doins xdao/pixmap_help.png 
	doins xdao/pixmap_dumpcd.png
	doins xdao/gcdmaster.png
	# application links
	# gcdmaster.desktop in /opt/gnome/share/gnome/apps/Applications
	insinto /opt/gnome/share/gnome/apps/Applications
	doins xdao/gcdmaster.desktop
	# 
	# man pages
	# cdrdao.1 in /usr/share/man/man1/
	into /usr
	newman dao/cdrdao.man cdrdao.1
	# xcdrdao.1 renamed to gcdmaster.1 in /opt/gnome/share/man/man1/
	into /opt/gnome
	newman xdao/xcdrdao.man gcdmaster.1
	# 
	# documentation
	docinto ""
	dodoc COPYING CREDITS INSTALL README* Release*
}
