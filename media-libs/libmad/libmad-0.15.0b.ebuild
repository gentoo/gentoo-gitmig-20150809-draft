# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmad/libmad-0.15.0b.ebuild,v 1.2 2003/07/17 10:27:55 raker Exp $

IUSE="debug"

DESCRIPTION="\"M\"peg \"A\"udio \"D\"ecoder library"
HOMEPAGE="http://mad.sourceforge.net/
	http://www.underbit.com/products/mad/"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	!media-sound/mad"

S=${WORKDIR}/${P}

src_compile() {
	local myconf

	myconf="--with-gnu-ld"
	# --enable-speed         optimize for speed over accuracy
	# --enable-accuracy      optimize for accuracy over speed
	# --enable-experimental  enable code using the EXPERIMENTAL
	#                        preprocessor define

	use debug && myconf="${myconf} --enable-debugging" \
		|| myconf="${myconf} --disable-debugging"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION

	dodir /usr/lib/pkgconfig
	insinto /usr/lib/pkgconfig
	doins ${FILESDIR}/mad.pc
}
