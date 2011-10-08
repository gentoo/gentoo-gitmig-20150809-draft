# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/optipng/optipng-0.6.5.ebuild,v 1.4 2011/10/08 16:53:33 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Compress PNG files without affecting image quality"
HOMEPAGE="http://optipng.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e '/^C/s: -O2.*: $(GENTOO_CFLAGS) -Wall:' \
		-e '/^LD/s: -s$: $(GENTOO_LDFLAGS):' \
		src/scripts/gcc.mak.in \
		lib/pngxtern/scripts/gcc.mak.in \
		|| die "sed failed"

	if has_version "<media-libs/libpng-1.5:0"; then
		cp lib/libpng/pngpriv.h src/ || die
		rm -rf lib/{libpng,zlib}
		epatch "${FILESDIR}"/${P}-libpng-1.4.8.patch
	else
		rm -rf lib/zlib
	fi
}

src_configure() {
	./configure \
		$(has_version "<media-libs/libpng-1.5:0" && echo -with-system-libpng) \
		-with-system-zlib \
		|| die "configure failed"
}

src_compile() {
	emake \
		-C src \
		-f scripts/gcc.mak \
		CC="$(tc-getCC)" \
		GENTOO_CFLAGS="${CFLAGS}" \
		GENTOO_LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin src/optipng || die "dobin failed"
	dodoc README.txt doc/*.txt || die
	dohtml doc/*.html || die
	doman man/optipng.1 || die
}
