# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-encoder/x264-encoder-0.0.20110825.ebuild,v 1.2 2011/09/07 15:09:35 aballier Exp $

EAPI=4
inherit eutils multilib toolchain-funcs versionator

MY_P=x264-snapshot-$(get_version_component_range 3)-2245

DESCRIPTION="A free commandline encoder for X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
SRC_URI="http://ftp.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug ffmpeg mp4 +threads"

RDEPEND="ffmpeg? ( media-video/ffmpeg )
	mp4? ( >=media-video/gpac-0.4.1_pre20060122 )
	~media-libs/x264-${PV}"
DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.2 )
	x86? ( || ( >=dev-lang/yasm-0.6.2 dev-lang/nasm )
		!<dev-lang/yasm-0.6.2 )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	tc-export CC

	local myconf=""
	use debug && myconf+=" --enable-debug"
	use ffmpeg || myconf+=" --disable-lavf --disable-swscale"
	use mp4 || myconf+=" --disable-gpac"
	use threads || myconf+=" --disable-thread"

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-avs \
		--disable-ffms \
		--extra-asflags="${ASFLAGS}" \
		--extra-cflags="${CFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--host="${CHOST}" \
		--system-libx264 \
		${myconf} \
		|| die
}
