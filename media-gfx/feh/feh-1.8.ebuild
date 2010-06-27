# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.8.ebuild,v 1.5 2010/06/27 10:56:23 fauli Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="https://derf.homelinux.org/~derf/projects/feh/"
SRC_URI="http://www.chaosdorf.de/~derf/feh/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="test xinerama"

COMMON_DEPEND=">=media-libs/giblib-1.2.4
	media-libs/imlib2
	>=media-libs/libpng-1.2.43
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	>=media-libs/jpeg-8a"
DEPEND="${COMMON_DEPEND}
	x11-libs/libXt
	x11-proto/xproto
	test? ( dev-perl/Test-Command )"

pkg_setup() {
	fehopts=(
		"DESTDIR=${D}"
		"PREFIX=/usr"
		"doc_dir=${D}/usr/share/doc/${PF}"
		)
}

src_prepare() {
	if ! use xinerama; then
		sed -i -e '/^xinerama/d' config.mk || die
	fi
}

src_compile() {
	tc-export CC
	emake "${fehopts[@]}" || die
}

src_test() {
	if has_version ">=dev-lang/perl-5.10"; then
		emake test || die
	fi
}

src_install() {
	emake "${fehopts[@]}" install || die
	prepalldocs
}
