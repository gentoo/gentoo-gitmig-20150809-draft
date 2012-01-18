# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.2.0_pre1-r2.ebuild,v 1.7 2012/01/18 19:18:59 jer Exp $

EAPI=3
inherit eutils toolchain-funcs

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -hppa ppc x86"
IUSE="exif nls"

RDEPEND="media-libs/libpng
	virtual/jpeg
	exif? ( media-gfx/exiv2 )
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P/_/}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-4.diff \
		"${FILESDIR}"/traypatch.diff \
		"${FILESDIR}"/${P}-desktop-entry.patch \
		"${FILESDIR}"/${P}-new-gtk-object-system.diff \
		"${FILESDIR}"/${P}-fix-array-boundaries.patch \
		"${FILESDIR}"/${P}-fix-segfault-comment.patch \
		"${FILESDIR}"/${P}-libpng15.patch

	# $X_LIBS fails to bring in -lX11 and the build fails with undefined
	# references with strict linker
	sed -i -e 's:view_LDADD =:view_LDADD = -lX11 -lm:' src/Makefile.{am,in} || die
	#Bug 325879
	sed -i -e '1i #pragma GCC optimize ("O0")' src/comment.c || die
}

src_configure() {
	tc-export CC
	econf \
		--with-gtk2 \
		$(use_enable exif) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" desktopdir="/usr/share/applications" \
		install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
