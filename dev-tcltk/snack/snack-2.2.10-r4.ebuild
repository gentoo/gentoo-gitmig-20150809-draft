# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.10-r4.ebuild,v 1.3 2010/04/05 14:02:59 jlec Exp $

EAPI="3"

PYTHON_DEPEND="python? *"
SUPPORT_PYTHON_ABIS="1"
PYTHON_MODNAME="tkSnack.py"

inherit eutils distutils multilib

DESCRIPTION="The Snack Sound Toolkit (Tcl)"
HOMEPAGE="http://www.speech.kth.se/snack/"
SRC_URI="http://www.speech.kth.se/snack/dist/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
IUSE="alsa examples python threads vorbis"

RESTRICT="test" # Bug 78354

DEPEND="
	>dev-lang/tcl-8.4.3
	>dev-lang/tk-8.4.3
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${PN}${PV}/unix"

src_prepare() {
	# bug 226137 - snack depends on alsa private symbol _snd_pcm_mmap_hw_ptr
	epatch "${FILESDIR}"/alsa-undef-sym.patch
	# bug 270839 - error from /usr/include/bits/mathcalls.h:310
	sed -i -e 's|^\(#define roundf(.*\)|//\1|' ../generic/jkFormatMP3.c

	# adds -install_name (soname on Darwin)
	[[ ${CHOST} == *-darwin* ]] && epatch "${FILESDIR}"/${P}-darwin.patch
}

src_configure() {
	local myconf="--libdir="${EPREFIX}"/usr/$(get_libdir) --includedir="${EPREFIX}"/usr/include"

	use alsa && myconf="${myconf} --enable-alsa"
	use threads && myconf="${myconf} --enable-threads"

	if use vorbis ; then
		myconf="${myconf} --with-ogg-include="${EPREFIX}"/usr/include"
		myconf="${myconf} --with-ogg-lib="${EPREFIX}"/usr/$(get_libdir)"
	fi

	econf ${myconf} || die "configure failed"
}

src_compile() {
	# We do not want to run distutils_src_compile
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use python ; then
		cd "${S}"/../python
		distutils_src_install
	fi

	cd "${S}"/..

	dodoc README changes || die
	dohtml doc/* || die

	if use examples ; then
		sed -i -e 's/wish[0-9.]+/wish/g' demos/tcl/* || die
		docinto examples/tcl
		dodoc demos/tcl/* || die

		if use python ; then
			docinto examples/python
			dodoc demos/python/* || die
		fi
	fi
}
