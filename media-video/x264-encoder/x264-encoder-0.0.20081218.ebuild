# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-encoder/x264-encoder-0.0.20081218.ebuild,v 1.3 2009/04/27 23:58:54 patrick Exp $

EAPI="1"
inherit multilib eutils toolchain-funcs versionator

MY_P="x264-snapshot-$(get_version_component_range 3)-2245"

DESCRIPTION="A free commandline encoder for X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug +mp4 +threads"

RDEPEND="mp4? ( >=media-video/gpac-0.4.1_pre20060122 )
	~media-libs/x264-${PV}"

DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.1 )
	x86? ( || ( >=dev-lang/yasm-0.6.2 dev-lang/nasm ) )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
	dev-util/pkgconfig"

# Block older than 0.6.2 versions of yasm
# It generates incorect pic code and will cause segfaults
# See http://www.tortall.net/projects/yasm/ticket/114
DEPEND="${DEPEND}
	x86? ( !<dev-lang/yasm-0.6.2 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-nostrip.patch"
	epatch "${FILESDIR}/${PN}-nolib-20081006.patch"
}

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--enable-pic --enable-shared \
		"--extra-cflags=${CFLAGS}" \
		"--extra-ldflags=${LDFLAGS}" \
		"--extra-asflags=${ASFLAGS}" \
		"--host=${CHOST}" \
		${myconf} \
		$(use_enable threads pthread) \
		$(use_enable mp4 mp4-output) \
		|| die "configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS doc/*.txt
}
