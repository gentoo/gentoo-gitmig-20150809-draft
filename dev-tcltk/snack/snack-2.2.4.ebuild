# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/snack/snack-2.2.4.ebuild,v 1.9 2005/09/04 12:25:40 matsuu Exp $

inherit eutils
IUSE="alsa vorbis"

DESCRIPTION="The Snack Sound Toolkit (Tcl)"
HOMEPAGE="http://www.speech.kth.se/snack/"
SRC_URI="http://www.speech.kth.se/~kare/${PN}${PV}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86 ~ppc amd64 sparc ppc64"
SLOT="0"

DEPEND=">dev-lang/tcl-8.4.3
	>dev-lang/tk-8.4.3
	vorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/${PN}${PV}/unix

src_compile() {
	local myconf="--enable-threads"

	use alsa && myconf="${myconf} --enable-alsa"

	if use vorbis ; then
		myconf="${myconf} --with-ogg-include=${ROOT}/usr/include"
		myconf="${myconf} --with-ogg-lib=${ROOT}/usr/$(get_libdir)"
	fi

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D}usr install || die "make install failed"
	cd ..
	dodoc BSD.txt  COPYING  README changes
	dohtml doc/*
}
