# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/progsreiserfs/progsreiserfs-0.3.0.4.ebuild,v 1.8 2003/08/11 23:42:08 wwoods Exp $

inherit libtool

DESCRIPTION="library for accessing and manipulating reiserfs partitions"
HOMEPAGE="http://reiserfs.linux.kiev.ua/"
SRC_URI="http://reiserfs.linux.kiev.ua/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc hppa amd64 alpha"
IUSE="nls debug"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use debug && myconf="${myconf} --disable-debug"

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
