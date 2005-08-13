# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gentoo-vdr-scripts/gentoo-vdr-scripts-0.1_alpha1.ebuild,v 1.2 2005/08/13 12:06:17 zzam Exp $

inherit eutils

SRC_URI="mirrors://gentoo/${P}.tgz"
DESCRIPTION="scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-merge-commands.diff"
}

src_install() {
	cd ${S}
	make install DESTDIR="${D}"
	dodoc README TODO
}

pkg_postinst() {
	einfo "This packet contains no shutdown-script up to now."
	einfo
	ewarn "This is an alpha release!"
	ewarn "Please test carefully that everything works as expected."
}
