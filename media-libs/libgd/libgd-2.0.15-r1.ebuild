# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.15-r1.ebuild,v 1.5 2004/02/20 10:31:41 mr_bones_ Exp $

inherit eutils libtool

MY_P=${P/lib/}
GIF_PATCH=patch_gd${PV}_gif_030616
DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/ http://www.rime.com.au/gd/"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz
	gif? ( http://downloads.rhyme.com.au/gd/${GIF_PATCH}.gz )"

LICENSE="as-is | BSD"
SLOT="2"
KEYWORDS="x86 ppc sparc ~mips hppa ~alpha"
IUSE="X gif"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=media-libs/freetype-2.1.2
	X? ( virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}
	elibtoolize
	[ -n "`use gif`" ] && epatch ${WORKDIR}/${GIF_PATCH}
}

src_compile() {
	econf \
		`use_with X x` \
		--includedir=/usr/include/gd-2 \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc INSTALL README*
	dohtml -r ./

	# make it slotable
	mv ${D}/usr/lib/libgd{,2}.a
	dosed 's:libgd\.a:libgd2.a:' /usr/lib/libgd.la
	dosym libgd2.a /usr/lib/libgd.a
	cd ${D}/usr/include/gd-2/
	for f in * ; do
		dosym gd-2/${f} /usr/include/${f}
	done
}
