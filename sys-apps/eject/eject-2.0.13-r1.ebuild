# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.13-r1.ebuild,v 1.1 2005/02/13 05:12:21 vapier Exp $

inherit eutils

DESCRIPTION="A command to eject a disc from the CD-ROM drive"
HOMEPAGE="http://eject.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="nls"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-kernel25-support.patch
	epatch "${FILESDIR}"/${P}-autoclose.patch
	epatch "${FILESDIR}"/${P}-finddev.patch
	epatch "${FILESDIR}"/${P}-header.patch
	epatch "${FILESDIR}"/${P}-use-mountpoints.patch

	if ! use nls ; then
		sed -i "s:SUBDIRS = po::" Makefile.in || die "sed nls failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README PORTING TODO AUTHORS NEWS PROBLEMS
}
