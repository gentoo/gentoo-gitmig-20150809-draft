# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264-svn/x264-svn-20070325.ebuild,v 1.2 2007/09/07 08:53:40 redhatter Exp $

inherit multilib eutils toolchain-funcs

IUSE="debug threads"

DESCRIPTION="A free library for encoding X264/AVC streams."
HOMEPAGE="http://developers.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=""

DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.0 )
	x86? ( dev-lang/nasm )
	x86-fbsd? ( dev-lang/nasm )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nostrip.patch"
	epatch "${FILESDIR}/${P}-onlylib.patch"
}

src_compile() {
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--enable-pic --enable-shared \
		"--extra-cflags=${CFLAGS}" \
		"--extra-ldflags=${LDFLAGS}" \
		"--extra-asflags=${ASFLAGS}" \
		$(use_enable debug) \
		$(use_enable threads pthread) \
		--disable-mp4-output \
		|| die "configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS
}

pkg_postinst() {
	elog "Please note that this package now only installs"
	elog "${PN} libraries. In order to have the encoder,"
	elog "please emerge media-video/x264-svn-encoder"
}
