# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libid3tag/libid3tag-0.15.0b.ebuild,v 1.1 2003/07/17 09:54:53 raker Exp $

IUSE="debug"

DESCRIPTION="The MAD id3tag library"
HOMEPAGE="http://mad.sourceforge.net/
	http://www.underbit.com/products/mad/"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	sys-libs/zlib
	!media-sound/mad"

S=${WORKDIR}/${P}

src_compile() {
	local myconf

	myconf="--with-gnu-ld"

	use debug && myconf="${myconf} --enable-debugging" \
		|| myconf="${myconf} --disable-debugging"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION
}
