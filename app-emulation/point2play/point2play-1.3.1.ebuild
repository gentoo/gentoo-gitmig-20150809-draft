# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/point2play/point2play-1.3.1.ebuild,v 1.5 2004/08/16 15:29:45 vapier Exp $

inherit eutils

MY_P=${PN}-small-${PV}
DESCRIPTION="graphical frontend for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${MY_P}.tgz"

LICENSE="point2play"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/x11
	>=dev-lang/python-2.3
	>=dev-python/pygtk-1.99.16
	>=x11-themes/gtk-engines-metal-2.2.0"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download the appropriate Point2Play archive (${MY_P}.tgz)"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	echo
	einfo "The archive should then be placed into ${DISTDIR}"
	echo
	ewarn "Please note that for some stupid reason Transgaming has"
	ewarn "started watermarking their downloads."
	ewarn "http://transgaming.org/forum/viewtopic.php?t=660"
	ewarn "This means you will have to rebuild the digest file"
	ewarn "before emerging it.  Just run this command:"
	ewarn "ebuild /usr/portage/app-emulation/${PN}/${PF}.ebuild digest"
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-fix-sound-test.patch
}

src_install() {
	mv usr ${D}/
	mv etc/X11/applnk ${D}/usr/share
}
