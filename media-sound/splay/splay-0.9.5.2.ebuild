# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/splay/splay-0.9.5.2.ebuild,v 1.12 2004/09/14 07:43:59 eradicator Exp $

IUSE=""

DESCRIPTION="an audio player, primarily for the console"
HOMEPAGE="http://splay.sourceforge.net/"
# Note non-standard sourceforge distribution location, so we can't use
# mirror://sourceforge/...
SRC_URI="http://splay.sourceforge.net/tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/libc"

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
	dodoc AUTHORS COPYING COPYING.LIB ChangeLog README README.LIB NEWS
}
