# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xcdroast/xcdroast-0.98_alpha10-r3.ebuild,v 1.1 2003/05/16 19:36:30 aliz Exp $

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Menu based front-end to mkisofs and cdrecord"
SRC_URI="http://www.xcdroast.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.xcdroast.org/"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

# WARNING: cdrtools and mkisofs versions hard coded, see below
DEPEND="=x11-libs/gtk+-1.2* 
	=dev-libs/glib-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	>=media-libs/giflib-3.0
	~app-cdr/cdrtools-1.11.33"
RDEPEND="~app-cdr/cdrtools-1.11.33"

src_compile() {
	# NOTE: This will need to be updated to work with future versions of
	# xcdroast (hardcoded versions).  The listed dependencies are part 
	# of the cdrtools package.
	mv xcdroast.h xcdroast.h.orig
	sed -e 's|CDRECORD_VERSION "1.10"|CDRECORD_VERSION "1.11a24"|' \
		-e 's|CDDA2WAV_VERSION "1.10"|CDDA2WAV_VERSION "1.11a24"|' \
		-e 's|READCD_VERSION "1.10"|READCD_VERSION "1.11a19"|' \
		-e 's|MKISOFS_VERSION "1.14"|MKISOFS_VERSION "1.15a23"|' \
		xcdroast.h.orig > xcdroast.h || die

	make PREFIX=/usr CC="gcc ${CFLAGS}" || die
}

src_install() {
	make PREFIX=/usr DESTDIR=${D} install || die
	chown root.wheel ${D}/usr/bin/xcdrgtk
	dodoc CHANGELOG COPYING DOCUMENTATION FAQ README* TRANSLATION.HOWTO

	# move man pages to /usr/share/man to be LFH compliant
	mv ${D}/usr/man ${D}/usr/share
}

pkg_postinst() {
	einfo "Due to limitations in the xcdroast program, the version of cdrtools"
	einfo "that it depends on must be hardcoded in the xcdroast program.  This"
	einfo "means you must have a specific version of cdrtools installed if you"
	einfo "plan to use xcdroast.  You may need to 'pin' the version of cdrtools"
	einfo "in use.  (See the portage manual for details)"
}
