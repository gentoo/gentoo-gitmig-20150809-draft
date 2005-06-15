# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xplanet/xplanet-1.1.2-r1.ebuild,v 1.1 2005/06/15 16:33:43 smithj Exp $

DESCRIPTION="A program to render images of the earth into the X root window"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://xplanet.sourceforge.net/"
DEPEND=">=sys-apps/sed-4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~alpha ~ppc ~hppa ~ppc64"
IUSE="gif jpeg X opengl truetype tiff png"

RDEPEND="X? ( virtual/x11 )
	opengl? ( virtual/opengl
		virtual/glut )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	truetype? ( =media-libs/freetype-2* )"

src_unpack() {
	unpack ${A}
	# fix GCC3.2 include re-ordering bug.
	cd ${S}
	sed -i 's,-I$prefix/include,,' configure
}

src_compile() {
	local myconf

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --with-x=no"

	use opengl \
		&& myconf="${myconf} --with-gl --with-glut --with-animation" \
		|| myconf="${myconf} --with-gl=no --with-glut=no --with-animation=no"

	use gif \
		&& myconf="${myconf} --with-gif" \
		|| myconf="${myconf} --with-gif=no"

	use jpeg \
		&& myconf="${myconf} --with-jpeg" \
		|| myconf="${myconf} --with-jpeg=no"

	use tiff \
		&& myconf="${myconf} --with-tiff" \
		|| myconf="${myconf} --with-tiff=no"

	use png \
		&& myconf="${myconf} --with-png --with-pnm" \
		|| myconf="${myconf} --with-png=no --with-pnm=no"

	use truetype \
		&& myconf="${myconf} --with-freetype" \
		|| myconf="${myconf} --with-freetype=no"

	econf ${myconf} || die

	# xplanet doesn't like to build parallel
	make || die
}

src_install () {
	einstall || die "einstall failed"
	dodoc AUTHORS README COPYING INSTALL NEWS ChangeLog TODO
}
