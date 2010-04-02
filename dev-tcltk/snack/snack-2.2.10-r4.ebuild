# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.10-r4.ebuild,v 1.2 2010/04/02 09:28:44 jlec Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"

inherit eutils multilib python

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
	emake || die "make failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use python ; then
		cd "${S}"/../python
		python setup.py install --root="${ED}" || die
	fi

	cd "${S}"/..

	dodoc README changes
	dohtml doc/*

	if use examples ; then
		sed -i -e 's/wish[0-9.]+/wish/g' demos/tcl/* || die
		docinto examples/tcl
		dodoc demos/tcl/*

		if use python ; then
			docinto examples/python
			dodoc demos/python/*
		fi
	fi
}

pkg_postinst() {
	python_mod_optimize tkSnack.py
}

pkg_postrm() {
	python_mod_cleanup tkSnack.py
}
