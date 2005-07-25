# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.13.ebuild,v 1.19 2005/07/25 20:05:51 flameeyes Exp $

inherit eutils

DESCRIPTION="A command to eject a disc from the CD-ROM drive"
HOMEPAGE="http://eject.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND="virtual/libc
	!virtual/eject"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
PROVIDE="virtual/eject"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Get this puppy working with kernel 2.5.x
	# <azarah@gentoo.org> (06 March 2003)
	epatch "${FILESDIR}/${P}-kernel25-support.patch"

	# Fix stupid includes (bug #41856)
	sed -i \
		-e 's|-I/usr/src/linux -I/usr/src/linux|-I/usr/include|' \
		${S}/Makefile.in \
		|| die "sed Makefile.in failed"

	if ! use nls
		then
		sed -i "s:SUBDIRS = po::" Makefile.in || die "sed nls failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README PORTING TODO AUTHORS NEWS PROBLEMS
}
