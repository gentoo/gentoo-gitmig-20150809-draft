# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.13-r2.ebuild,v 1.4 2005/07/23 15:12:30 solar Exp $

inherit eutils

DESCRIPTION="A command to eject a disc from the CD-ROM drive"
HOMEPAGE="http://eject.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="nls"

DEPEND=""
PROVIDE="virtual/eject"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-kernel25-support.patch
	epatch "${FILESDIR}"/${P}-autoclose.patch
	epatch "${FILESDIR}"/${P}-finddev.patch
	epatch "${FILESDIR}"/${P}-header.patch
	epatch "${FILESDIR}"/${P}-use-mountpoints.patch
	epatch "${FILESDIR}"/${P}-close-check.patch
	epatch "${FILESDIR}"/${P}-prefix-defaultdevice-with-dev.patch
	epatch "${FILESDIR}"/${P}-xmalloc.patch
	epatch "${FILESDIR}"/${P}-xregcomp.patch
	epatch "${FILESDIR}"/${P}-no-umount.patch
	epatch "${FILESDIR}"/${P}-toggle.patch
	epatch "${FILESDIR}"/${P}-fstab-error.patch
	epatch "${FILESDIR}"/${P}-pumount.patch
	epatch "${FILESDIR}"/${P}-i18n-uclibc.patch

	sed -i '/^AM_CFLAGS/s:-O3::' Makefile.in
	if ! use nls ; then
		sed -i "s:SUBDIRS = po::" Makefile.in || die "sed nls failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README PORTING TODO AUTHORS NEWS PROBLEMS
}
