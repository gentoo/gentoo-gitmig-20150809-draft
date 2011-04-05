# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.10-r2.ebuild,v 1.10 2011/04/05 05:29:01 ulm Exp $

inherit eutils multilib

DESCRIPTION="The Snack Sound Toolkit (Tcl)"
HOMEPAGE="http://www.speech.kth.se/snack/"
SRC_URI="http://www.speech.kth.se/snack/dist/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
SLOT="0"
IUSE="alsa examples python threads vorbis"

RESTRICT="test" # Bug 78354

DEPEND=">dev-lang/tcl-8.4.3
	>dev-lang/tk-8.4.3
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${PV}/unix"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 226137 - snack depends on alsa private symbol _snd_pcm_mmap_hw_ptr
	epatch "${FILESDIR}"/alsa-undef-sym.patch
	# bug 270839 - error from /usr/include/bits/mathcalls.h:310
	sed -i -e 's|^\(#define roundf(.*\)|//\1|' ../generic/jkFormatMP3.c
}

src_compile() {
	local myconf="--libdir=/usr/$(get_libdir) --includedir=/usr/include"

	use alsa && myconf="${myconf} --enable-alsa"
	use threads && myconf="${myconf} --enable-threads"

	if use vorbis ; then
		myconf="${myconf} --with-ogg-include=/usr/include"
		myconf="${myconf} --with-ogg-lib=/usr/$(get_libdir)"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use python ; then
		cd "${S}"/../python
		python setup.py install --root="${D}" || die
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
