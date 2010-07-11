# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.2.6.ebuild,v 1.3 2010/07/11 17:51:20 armin76 Exp $

inherit eutils flag-o-matic toolchain-funcs autotools

DESCRIPTION="Library for using System.Drawing with mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="exif gif jpeg tiff"

RDEPEND=">=dev-libs/glib-2.6
		 >=media-libs/freetype-2
		 >=media-libs/fontconfig-2
		   media-libs/libpng
		x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXt
		 exif? ( media-libs/libexif )
		 gif? ( >=media-libs/giflib-4.1.3 )
		 jpeg? ( media-libs/jpeg )
		 tiff? ( media-libs/tiff )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#epatch ${FILESDIR}/${PN}-1.1.13-libungif-configure-fix.diff
	epatch "${FILESDIR}/${PN}-1.2.5-imglibs.patch"
	epatch "${FILESDIR}/${PN}-1.2.6-autotool-variables.patch"
	eautoreconf
}

src_compile() {
	if [[ "$(gcc-major-version)" -gt "3" ]] || \
	   ( [[ "$(gcc-major-version)" -eq "3" ]] && [[ "$(gcc-minor-version)" -gt "3" ]] )
	then
		append-flags -fno-inline-functions
	fi

	# Disable glitz support as libgdiplus does not use it, and it causes errors
	econf --disable-glitz          \
		  $(use_with exif libexif) \
		  $(use_with gif libgif)   \
		  $(use_with jpeg libjpeg) \
		  $(use_with tiff libtiff) || die "configure failed"

	# attribute ((__stdcall__)) generates warnings on ppc
	if use ppc ; then
		sed -i -e 's:-Werror::g' src/Makefile
	fi

	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
