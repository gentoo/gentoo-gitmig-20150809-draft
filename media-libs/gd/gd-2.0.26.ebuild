# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.26.ebuild,v 1.3 2004/07/22 19:52:39 vapier Exp $

inherit eutils

GIF_PATCH=patch_gd2.0.26_gif_040622
DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/ http://www.rime.com.au/gd/"
SRC_URI="http://www.boutell.com/gd/http/${P}.tar.gz
	gif? ( http://downloads.rhyme.com.au/gd/${GIF_PATCH}.gz )"

LICENSE="as-is | BSD"
SLOT="2"
KEYWORDS="x86 ppc sparc ~mips ~alpha arm hppa amd64 ~ia64 ~s390 ppc64"
IUSE="jpeg png X truetype gif"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.5 )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use gif && epatch ${WORKDIR}/${GIF_PATCH}
}

src_compile() {
	econf \
		`use_with png` \
		`use_with truetype freetype` \
		`use_with jpeg` \
		`use_with X xpm` \
		--includedir=/usr/include/gd-2 \
		${myconf} \
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
