# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgd/libgd-2.0.22.ebuild,v 1.1 2004/02/03 02:26:34 vapier Exp $

inherit eutils

MY_P=${P/lib/}
GIF_PATCH=patch_gd2.0.21_gif_040120
DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/ http://www.rime.com.au/gd/"
SRC_URI="http://www.boutell.com/gd/http/${MY_P}.tar.gz
	gif? ( http://downloads.rhyme.com.au/gd/${GIF_PATCH}.gz )"

LICENSE="as-is | BSD"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~hppa ~arm ~alpha"
IUSE="jpeg png X truetype gif"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.2 )
	X? ( virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	use gif && epatch ${WORKDIR}/${GIF_PATCH}
}

src_compile() {
	local myconf=""
	use truetype \
		&& myconf="${myconf} --with-freetype=yes" \
		|| myconf="${myconf} --with-freetype=no"
	use png \
		&& myconf="${myconf} --with-png=yes" \
		|| myconf="${myconf} --with-png=no"
	econf \
		`use_with png` \
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
