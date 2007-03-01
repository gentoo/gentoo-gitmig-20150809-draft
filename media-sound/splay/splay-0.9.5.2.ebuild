# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/splay/splay-0.9.5.2.ebuild,v 1.16 2007/03/01 17:31:44 aballier Exp $

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
	# Prevent collisions with media-sound/mp3blaster
	# bug #148293
	mv "apps/splay.1" "apps/osplay.1" || die "moving man failed"
	sed -i "s/splay.1/osplay.1/" apps/Makefile.in\
		|| die "sedding makefile failed"
	# Force compilation to omit X support according to BUG #5856
	# even when qt is present on the system.
	export ac_cv_lib_qt_main=no
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# Specify man-page to prevent xsplay.1 from being installed
	einstall man_MANS=osplay.1 || die "einstall failed"
	#rename splay so that it does not collide with media-sound/mp3blaster
	# bug #148293
	mv "${D}/usr/bin/splay" "${D}/usr/bin/osplay"\
		|| die "moving splay executable failed"

	dodoc AUTHORS ChangeLog README README.LIB NEWS
}

pkg_postinst() {
	elog "Please note that splay has been renamed to osplay"
	elog "in order to prevent collisions with media-sound/mp3blaster"
}
