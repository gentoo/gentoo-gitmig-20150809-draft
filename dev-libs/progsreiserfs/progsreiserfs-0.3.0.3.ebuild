# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/progsreiserfs/progsreiserfs-0.3.0.3.ebuild,v 1.9 2003/06/20 22:38:18 weeve Exp $

IUSE="nls"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="A library for accessing and manipulating reiserfs partitions"
SRC_URI="http://reiserfs.linux.kiev.ua/${P}.tar.gz"
HOMEPAGE="http://reiserfs.linux.kiev.ua/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
        unpack ${A}
        if [ "${ARCH}" = "sparc" ]
        then
		cd ${S}
                epatch ${FILESDIR}/${P}-sparc-linux.diff
        fi
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	[ -z "${DEBUGBUILD}" ] && myconf="${myconf} --disable-debug"

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
