# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/splay/splay-0.9.5.2.ebuild,v 1.3 2003/07/12 20:30:59 aliz Exp $

DESCRIPTION="splay is an audio player, primarily for the console"
HOMEPAGE="http://splay.sourceforge.net/"
# Note non-standard sourceforge distribution location, so we can't use
# mirror://sourceforge/...
SRC_URI="http://splay.sourceforge.net/tgz/splay-0.9.5.2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"

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
