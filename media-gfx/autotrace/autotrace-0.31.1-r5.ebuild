# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r5.ebuild,v 1.8 2010/07/10 17:19:34 armin76 Exp $

EAPI=1
inherit autotools eutils

DESCRIPTION="Converts Bitmaps to vector-graphics"
HOMEPAGE="http://autotrace.sourceforge.net/"
SRC_URI="mirror://sourceforge/autotrace/${P}.tar.gz
	mirror://debian/pool/main/a/${PN}/${PN}_${PV}-13.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="+imagemagick"

RDEPEND="media-libs/libexif
	>=media-libs/libpng-1.2.43-r2:0
	>=media-libs/ming-0.3.0
	>=media-gfx/pstoedit-3.45-r1
	imagemagick? ( >=media-gfx/imagemagick-6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PN}_${PV}-13.diff
	epatch "${FILESDIR}"/${P}-swf-output.patch
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-pkgconfig.patch	# bug 283534

	# Fix broken Debian patchset wrt bug 321525
	sed -i \
		-e 's:libpng12:libpng:' \
		configure.in || die

	eautoreconf
}

src_compile() {
	# Autotrace will autolink to ming if present. And fail to autoconf, and then
	# ./configure without pstoedit. Forcing on.
	econf \
		--disable-dependency-tracking \
		--with-ming \
		$(use_with imagemagick magick) \
		--with-pstoedit

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
