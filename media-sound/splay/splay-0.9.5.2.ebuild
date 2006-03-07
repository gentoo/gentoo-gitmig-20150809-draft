# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/splay/splay-0.9.5.2.ebuild,v 1.15 2006/03/07 15:53:53 flameeyes Exp $

inherit eutils

IUSE=""

DESCRIPTION="an audio player, primarily for the console"
HOMEPAGE="http://splay.sourceforge.net/"
SRC_URI="http://splay.sourceforge.net/tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

src_unpack() {
	unpack ${A}
	cd ${S}/apps
	epatch ${FILESDIR}/${P}-external-id3lib.diff
}

src_compile() {
	# Force compilation to omit X support according to BUG #5856
	# even when qt is present on the system.
	export ac_cv_lib_qt_main=no
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# Specify man-page to prevent xsplay.1 from being installed
	einstall man_MANS=splay.1 || die "einstall failed"
	dodoc AUTHORS ChangeLog README README.LIB NEWS
}
