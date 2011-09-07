# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264/x264-0.0.20110825.ebuild,v 1.1 2011/09/07 02:24:28 chutzpah Exp $

EAPI=4
inherit eutils flag-o-matic multilib toolchain-funcs versionator

MY_P=x264-snapshot-$(get_version_component_range 3)-2245

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="custom-cflags debug +threads pic static-libs"

RDEPEND=""
DEPEND="amd64? ( >=dev-lang/yasm-0.6.2 )
	x86? ( >=dev-lang/yasm-0.6.2 )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS doc/*.txt"

src_configure() {
	tc-export CC

	local myconf=""
	use debug && myconf+=" --enable-debug"
	use static-libs && myconf+=" --enable-static"
	use threads || myconf+=" --disable-thread"

	# let upstream pick the optimization level by default
	use custom-cflags || filter-flags -O?

	if use x86 && use pic; then
		myconf+=" --disable-asm"
	fi

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-cli \
		--disable-avs \
		--disable-lavf \
		--disable-swscale \
		--disable-ffms \
		--disable-gpac \
		--enable-pic \
		--enable-shared \
		--host="${CHOST}" \
		${myconf} \
		|| die

	# this is a nasty workaround for bug #376925 as upstream doesn't like us
	# fiddling with their CFLAGS
	if use custom-cflags; then
		local cflags
		cflags="$(grep "^CFLAGS=" config.mak | sed 's/CFLAGS=//')"
		cflags="${cflags//$(get-flag O)/}"
		cflags="${cflags//-O?/$(get-flag O)}"
		cflags="${cflags//-g/}"
		sed -i "s:^CFLAGS=.*:CFLAGS=${cflags//:/\\:}:" config.mak
	fi
}
