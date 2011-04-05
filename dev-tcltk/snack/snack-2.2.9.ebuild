# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.9.ebuild,v 1.9 2011/04/05 05:29:01 ulm Exp $

inherit eutils multilib

DESCRIPTION="The Snack Sound Toolkit (Tcl)"
HOMEPAGE="http://www.speech.kth.se/snack/"
SRC_URI="http://www.speech.kth.se/~kare/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
SLOT="0"
IUSE="alsa python threads vorbis"

DEPEND=">dev-lang/tcl-8.4.3
	>dev-lang/tk-8.4.3
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libvorbis )
	python? ( dev-lang/python )"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	local myconf="--libdir=/usr/$(get_libdir) --includedir=/usr/include"

	use alsa && myconf="${myconf} --enable-alsa"
	use threads && myconf="${myconf} --enable-threads"

	if use vorbis ; then
		myconf="${myconf} --with-ogg-include=/usr/include"
		myconf="${myconf} --with-ogg-lib=/usr/$(get_libdir)"
	fi

	cd ${S}/unix
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd ${S}/unix
	make DESTDIR=${D} install || die "make install failed"

	if use python ; then
		cd ${S}/python
		python setup.py install --root=${D} || die
	fi

	cd ${S}

	dodoc README changes
	dohtml doc/*
}
