# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/progsreiserfs/progsreiserfs-0.3.0.3.ebuild,v 1.2 2004/04/27 21:55:35 agriffis Exp $

inherit libtool eutils

DESCRIPTION="library for accessing and manipulating reiserfs partitions"
HOMEPAGE="http://reiserfs.linux.kiev.ua/"
SRC_URI="http://reiserfs.linux.kiev.ua/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="nls debug"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	[ "${ARCH}" = "sparc" ] && cd ${S} && epatch ${FILESDIR}/${P}-sparc-linux.diff
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use debug && myconf="${myconf} --disable-debug"

	elibtoolize
	econf ${myconf} || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS \
		TODO COPYING.NAMESYS COPYING doc/API
	docinto demos
	dodoc demos/*.c
}
