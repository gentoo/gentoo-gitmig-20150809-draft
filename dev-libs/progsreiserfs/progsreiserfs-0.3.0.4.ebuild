# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/progsreiserfs/progsreiserfs-0.3.0.4.ebuild,v 1.3 2003/06/16 01:26:37 gmsoft Exp $

IUSE="nls"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="A library for accessing and manipulating reiserfs partitions"
SRC_URI="http://reiserfs.linux.kiev.ua/${P}.tar.gz"
HOMEPAGE="http://reiserfs.linux.kiev.ua/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc hppa"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	[ -z "${DEBUGBUILD}" ] && myconf="${myconf} --disable-debug"

	elibtoolize
	econf ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS \
		TODO COPYING.NAMESYS COPYING doc/API
	docinto demos
	dodoc demos/*.c
}
