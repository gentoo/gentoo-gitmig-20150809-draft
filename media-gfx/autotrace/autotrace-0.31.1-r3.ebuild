# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r3.ebuild,v 1.10 2009/12/09 20:38:45 ranger Exp $

EAPI=1

inherit base eutils autotools

DESCRIPTION="Converts Bitmaps to vector-graphics"
SRC_URI="mirror://sourceforge/autotrace/${P}.tar.gz
	mirror://debian/pool/main/a/autotrace/autotrace_0.31.1-13.diff.gz"

HOMEPAGE="http://autotrace.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE="+imagemagick +pdf"

RDEPEND="media-libs/libexif
	>=media-libs/libpng-1.2.5-r4
	>=media-libs/ming-0.3.0
	pdf? ( media-gfx/pstoedit )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=(
	"${WORKDIR}"/autotrace_0.31.1-13.diff
	"${FILESDIR}"/${P}-swf-output.patch
	"${FILESDIR}"/${P}-m4.patch
)

src_compile() {
	# Autotrace will autolink to ming if present. Forcing on.
	econf \
		--disable-dependency-tracking \
		--with-ming \
		$(use_with imagemagick magick) \
		$(use_with pdf pstoedit) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
