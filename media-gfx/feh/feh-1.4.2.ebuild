# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.4.2.ebuild,v 1.3 2010/04/05 18:10:53 armin76 Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="https://derf.homelinux.org/~derf/projects/feh/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 sparc x86"
IUSE="xinerama"

COMMON_DEPEND=">=media-libs/giblib-1.2.4
	media-libs/imlib2
	media-libs/libpng
	x11-libs/libXext
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	>=media-libs/jpeg-8a"
DEPEND="${COMMON_DEPEND}
	x11-libs/libXt
	x11-proto/xproto"

pkg_setup() {
	fehopts="DESTDIR=${D}
		doc_dir=${D}/usr/share/doc/${PF}
		PREFIX=/usr"
}

src_prepare() {
	if ! use xinerama; then
		sed -i -e '/^xinerama/d' config.mk || die
	fi

	sed -i -e 's:LDFLAGS +=:LDLIBS =:' config.mk || die

	sed -i \
		-e 's:${LDFLAGS}:${LDLIBS}:' \
		-e 's:${CC} ${CFLAGS}:${CC} ${LDFLAGS} ${CFLAGS}:' \
		src/Makefile || die

	sed -i \
		-e 's:${doc_dir}/feh:${doc_dir}:g' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake ${fehopts} || die
}

src_install() {
	emake ${fehopts} install || die
	prepalldocs
}
