# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.8-r4.ebuild,v 1.6 2004/03/17 15:36:46 phosphan Exp $

inherit gcc eutils

S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroines.sourceforge.net/"

RDEPEND="virtual/x11
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ `gcc-major-version` = '3' ] ;
	then
		# gcc3.2 fix (from bug #7227)
		epatch ${FILESDIR}/xmovie-gcc3-gentoo.patch
		# gcc 3.3 fix from bug #32965
		epatch ${FILESDIR}/xmovie-1.8-gcc3.3.patch
	fi
}

src_compile() {
	local myconf
	use mmx || myconf="${myconf} --no-mmx"

	./configure ${myconf} || die
	emake || die

}

src_install () {

	into /usr
	dobin xmovie/`uname -m`/xmovie
	dodoc README
	dohtml docs/*.html

}
