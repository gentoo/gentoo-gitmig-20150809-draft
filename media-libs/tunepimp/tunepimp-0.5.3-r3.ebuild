# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.5.3-r3.ebuild,v 1.2 2011/02/22 23:59:07 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit autotools distutils eutils multilib

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

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

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

	if use python; then
		pushd python > /dev/null
		distutils_src_compile
		popd > /dev/null
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	if use python; then
		pushd python > /dev/null
		distutils_src_install
		insinto /usr/share/doc/${PF}/examples
		doins examples/* || die "doins failed"
		popd > /dev/null
	fi

	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	if use python; then
		distutils_pkg_postinst
	fi
}

pkg_postrm() {
	if use python; then
		distutils_pkg_postrm
	fi
}
