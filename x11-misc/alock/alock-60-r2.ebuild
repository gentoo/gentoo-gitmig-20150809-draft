# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alock/alock-60-r2.ebuild,v 1.1 2007/07/05 17:42:14 hansmi Exp $

DESCRIPTION="alock - locks the local X display until a password is entered"
HOMEPAGE="
	http://code.google.com/p/alock/
	http://darkshed.net/projects/alock
"
SRC_URI="http://alock.googlecode.com/files/alock-svn-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	media-libs/imlib2
"
RDEPEND=""

MY_S="${WORKDIR}/alock-svn-${PV}"

src_unpack() {
	unpack "${A}"
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
