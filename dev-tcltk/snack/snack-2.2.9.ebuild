# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.9.ebuild,v 1.1 2005/04/02 23:39:33 matsuu Exp $

inherit eutils

DESCRIPTION="The Snack Sound Toolkit (Tcl)"
HOMEPAGE="http://www.speech.kth.se/snack/"
SRC_URI="http://www.speech.kth.se/~kare/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64"
SLOT="0"
IUSE="alsa oggvorbis python threads"

DEPEND=">dev-lang/tcl-8.4.3
	>dev-lang/tk-8.4.3
	alsa? ( media-libs/alsa-lib )
	oggvorbis? ( media-libs/libogg media-libs/libvorbis )
	python? ( virtual/python )"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	local myconf=""

	use alsa && myconf="${myconf} --enable-alsa"
	use threads && myconf="${myconf} --enable-threads"

	if use oggvorbis ; then
		myconf="${myconf} --with-ogg-include=/usr/include/ogg"
		myconf="${myconf} --with-ogg-lib=/usr/$(get_libdir)"
	fi

	cd ${S}/unix
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd ${S}/unix
	make DESTDIR=${D}usr install || die "make install failed"

	if use python ; then
		cd ${S}/python
		python setup.py install --root=${D} || die
	fi

	cd ${S}

	dodoc README changes
	dohtml doc/*
}
