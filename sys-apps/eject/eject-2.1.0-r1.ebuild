# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.1.0-r1.ebuild,v 1.4 2006/02/19 21:53:41 kumba Exp $

inherit eutils

DESCRIPTION="A command to eject a disc from the CD-ROM drive"
HOMEPAGE="http://eject.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND="!virtual/eject"
PROVIDE="virtual/eject"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.0.13-autoclose.patch
	epatch "${FILESDIR}"/${PN}-2.0.13-header.patch
	epatch "${FILESDIR}"/${PN}-2.0.13-use-mountpoints.patch
	epatch "${FILESDIR}"/${PN}-2.0.13-xmalloc.patch
	epatch "${FILESDIR}"/${P}-regcomp-check.patch
	epatch "${FILESDIR}"/${PN}-2.0.13-pumount.patch
	epatch "${FILESDIR}"/${PN}-2.0.13-i18n-uclibc.patch
	epatch "${FILESDIR}"/${P}-scsi-io-update.patch
	epatch "${FILESDIR}"/${P}-toggle.patch

	sed -i '/^AM_CFLAGS/s:-O3::' Makefile.in
	if ! use nls ; then
		sed -i "s:SUBDIRS = po::" Makefile.in || die "sed nls failed"
	fi

	# Fix busted timestamps in tarball
	touch -r aclocal.m4 configure.in
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README PORTING TODO AUTHORS NEWS PROBLEMS
}
