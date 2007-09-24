# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-svn-encoder/x264-svn-encoder-20070923.ebuild,v 1.2 2007/09/24 06:08:44 aballier Exp $

inherit multilib eutils toolchain-funcs

IUSE="debug mp4 gtk threads"

X264_SVN_P=${P/-encoder/}

DESCRIPTION="A free library for encoding X264/AVC streams."
HOMEPAGE="http://developers.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${X264_SVN_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="mp4? ( >=media-video/gpac-0.4.1_pre20060122 )
	gtk? ( >=x11-libs/gtk+-2.6.10 >=dev-libs/glib-2.10.3 )
	~media-libs/${X264_SVN_P}"

DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.0 )
	x86? ( || ( >=dev-lang/yasm-0.6.2 dev-lang/nasm ) )
	x86-fbsd? ( dev-lang/nasm )"

# Block older than 0.6.2 versions of yasm
# It generates incorect pic code and will cause segfaults
# See http://www.tortall.net/projects/yasm/ticket/114
DEPEND="${DEPEND}
	x86? ( !<dev-lang/yasm-0.6.2 )"

S=${WORKDIR}/${PN/-encoder/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nostrip.patch"
	epatch "${FILESDIR}/${P}-nolib.patch"
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
		${myconf} \
		$(use_enable threads pthread) \
		$(use_enable mp4 mp4-output) \
		$(use_enable gtk) \
		|| die "configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS
}
