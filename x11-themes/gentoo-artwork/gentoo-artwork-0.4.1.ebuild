# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gentoo-artwork/gentoo-artwork-0.4.1.ebuild,v 1.3 2005/08/23 23:28:14 spock Exp $

DESCRIPTION="A collection of miscellaneous Gentoo Linux logos and artwork"
SRC_URI="mirror://gentoo/gentoo-artwork-0.2.tar.bz2
		 mirror://gentoo/gentoo-artwork-0.3.tar.bz2
		 mirror://gentoo/gentoo-artwork-0.4.tar.bz2
		 mirror://gentoo/gentoo-artwork-0.4.1.tar.bz2"
HOMEPAGE="http://www.gentoo.org/index-graphics.html"

KEYWORDS="x86 ppc sparc amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="kde offensive"

DEPEND=""

src_unpack() {
	unpack gentoo-artwork-0.2.tar.bz2
	# rename unpacked dir so that updated files get overwritten
	mv ${WORKDIR}/gentoo-artwork-0.2 ${WORKDIR}/gentoo-artwork-0.3
	unpack gentoo-artwork-0.3.tar.bz2
	mv ${WORKDIR}/gentoo-artwork-0.3 ${WORKDIR}/gentoo-artwork-0.4
	unpack gentoo-artwork-0.4.tar.bz2
	mv ${WORKDIR}/gentoo-artwork-0.4 ${WORKDIR}/gentoo-artwork-0.4.1
	unpack gentoo-artwork-0.4.1.tar.bz2

	# remove misspelled files
	rm ${S}/icons/gentoo/{32x32,48x48,64x64}/slypheed.png

	if ! use offensive ; then
		for i in $(<${FILESDIR}/offensive_list) ; do
			rm -f "${S}/${i}"
		done
	fi
}

src_install() {
	# pixmaps
	dodir /usr/share/pixmaps/gentoo/
	cd ${S}/pixmaps
	cp -pPR . ${D}/usr/share/pixmaps/gentoo/
	rm ${D}/usr/share/pixmaps/gentoo/CREDITS

	if use kde ; then
		# a Gentoo colour scheme for KDE
		insinto /usr/share/apps/kdisplay/color-schemes
		doins ${S}/misc/Gentoo.kcsrc
	fi

	# Gentoo icons
	dodir /usr/share/icons/gentoo
	cp -pR ${S}/icons/gentoo/* ${D}/usr/share/icons/gentoo/

	# grub splash images
	dodir /usr/share/grub/splashimages
	insinto /usr/share/grub/splashimages
	doins ${S}/grub/*.xpm.gz

	# lilo splash images
	dodir /usr/share/lilo/splashimages
	insinto /usr/share/lilo/splashimages
	doins ${S}/lilo/*

	dodoc ${S}/pixmaps/CREDITS
}
