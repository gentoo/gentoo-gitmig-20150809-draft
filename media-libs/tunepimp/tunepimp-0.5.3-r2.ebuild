# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.5.3-r2.ebuild,v 1.10 2010/01/22 00:26:27 abcd Exp $

EAPI=2
inherit autotools eutils distutils multilib

MY_P=lib${P}

DESCRIPTION="TunePimp is a library to create MusicBrainz enabled tagging applications."
HOMEPAGE="http://www.musicbrainz.org/products/tunepimp"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="python"

RDEPEND="sys-libs/zlib
	dev-libs/expat
	net-misc/curl
	media-libs/flac
	media-libs/libmad
	>=media-libs/musicbrainz-2.1:1
	>=media-libs/libmp4v2-1.9
	media-libs/libofa
	media-libs/libvorbis
	sys-libs/readline"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-sound/trm"

# parallel build is broken - https://bugs.gentoo.org/204174
MAKEOPTS="${MAKEOPTS} -j1"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-libtool.patch \
		"${FILESDIR}"/${P}-build-fix.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-new_libmp4v2.patch

	sed -i -e "s: tta::" configure.in || die "sed failed"

	# Don't hardcode ".so", use get_modname instead
	sed -e "s|.so \$(top_srcdir)|$(get_modname) \$(top_srcdir)|g" \
		-i plugins/*/Makefile.*

	eautoreconf
}

src_configure() {
	default
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	if use python; then
		cd python
		distutils_src_install
		insinto /usr/share/doc/${PF}/examples
		doins examples/* || die "doins failed"
	fi
}
