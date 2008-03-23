# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alock/alock-60-r3.ebuild,v 1.4 2008/03/23 00:39:25 coldwind Exp $

inherit eutils

DESCRIPTION="locks the local X display until a password is entered"
HOMEPAGE="
	http://code.google.com/p/alock/
	http://darkshed.net/projects/alock
"
SRC_URI="http://alock.googlecode.com/files/alock-svn-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	media-libs/imlib2
"
RDEPEND=""

S=${WORKDIR}/alock-svn-${PV}

pkg_setup() {
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "media-libs/imlib2 has to be built with X support"
		die "emerge media-libs/imlib2 with USE=\"X\""
	fi
}

src_unpack() {
	unpack ${A}
	sed -i 's|\$(DESTDIR)\$(prefix)/man|\$(DESTDIR)\$(prefix)/share/man|g' \
		"${S}"/Makefile || die "sed failed"
}

src_compile() {
	econf --with-all || die
	emake || die
}

src_install() {
	dobin src/alock
	doman alock.1
	dodoc README.txt LICENSE.txt CHANGELOG.txt

	insinto /usr/share/alock/xcursors
	doins contrib/xcursor-*

	insinto /usr/share/alock/bitmaps
	doins bitmaps/*
}
