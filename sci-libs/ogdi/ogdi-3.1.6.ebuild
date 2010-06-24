# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ogdi/ogdi-3.1.6.ebuild,v 1.2 2010/06/24 14:49:17 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Open Geographical Datastore Interface, a GIS support library"
HOMEPAGE="http://ogdi.sourceforge.net"
SRC_URI="mirror://sourceforge/ogdi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="static-libs"

DEPEND="
	sci-libs/proj
	sys-libs/zlib
	dev-libs/expat"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -rf external
	epatch "${FILESDIR}"/${P}-unbundle-libs.patch
	epatch "${FILESDIR}"/${P}-fpic.patch
	sed 's:O2:O9:g' -i configure || die
}

src_configure() {
	export TOPDIR="${S}"
	export TARGET=`uname`
	export CFG="release"
	export LD_LIBRARY_PATH=$TOPDIR/bin/${TARGET}

	econf \
		--with-projlib="-L${EPREFIX}/usr/$(get_libdir) -lproj" \
		--with-zlib --with-expat
}

src_compile() {
	# bug #299239
	emake -j1 \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		SHLIB_LD="$(tc-getCC)" \
		|| die "make failed"
}

src_install() {
	mv "${S}"/bin/${TARGET}/*.so* "${S}"/lib/Linux/. || die "lib move failed"
	dobin "${S}"/bin/${TARGET}/*  || die
	insinto /usr/include
	doins ogdi/include/ecs.h ogdi/include/ecs_util.h || die
	dolib.so lib/${TARGET}/lib* || die
	if use static-libs; then
		dolib.a lib/${TARGET}/static/*.a || die
	fi
#	dosym libogdi31.so /usr/$(get_libdir)/libogdi.so || die "symlink failed"
	dodoc ChangeLog NEWS README || die
}
