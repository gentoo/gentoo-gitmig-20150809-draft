# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gentoo-vdr-scripts/gentoo-vdr-scripts-0.1_alpha3.ebuild,v 1.2 2005/09/12 13:38:10 swegener Exp $

IUSE=""

SRC_URI="http://dev.gentoo.org/~zzam/distfiles/${P}.tgz"
DESCRIPTION="scripts necessary for use of vdr as a set-top-box"
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc README TODO ChangeLog
}

pkg_postinst() {
	einfo "This packet contains no shutdown-script up to now."
	einfo
	ewarn "This is an alpha release!"
	ewarn "Please test carefully that everything works as expected."
}
