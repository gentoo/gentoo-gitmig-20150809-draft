# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alock/alock-60-r3.ebuild,v 1.2 2008/01/09 15:25:51 maekke Exp $

inherit eutils

DESCRIPTION="alock - locks the local X display until a password is entered"
HOMEPAGE="
	http://code.google.com/p/alock/
	http://darkshed.net/projects/alock
"
SRC_URI="http://alock.googlecode.com/files/alock-svn-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	media-libs/imlib2
"
RDEPEND=""

MY_S="${WORKDIR}/alock-svn-${PV}"

pkg_setup() {
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "media-libs/imlib2 has to be built with X support"
		die "emerge media-libs/imlib2 with USE=\"X\""
	fi
}

src_unpack() {
	unpack "${A}"
	sed -i 's|\$(DESTDIR)\$(prefix)/man|\$(DESTDIR)\$(prefix)/share/man|g' \
		"${MY_S}"/Makefile || die "sed failed"
}

src_compile() {
	cd "${MY_S}" || die

	econf --with-all || die
	emake || die
}

src_install() {
	cd "${MY_S}" || die

	dobin src/alock
	doman alock.1
	dodoc README.txt LICENSE.txt CHANGELOG.txt

	insinto /usr/share/alock/xcursors
	doins contrib/xcursor-*

	insinto /usr/share/alock/bitmaps
	doins bitmaps/*
}
