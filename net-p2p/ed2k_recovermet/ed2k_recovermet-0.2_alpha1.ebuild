# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k_recovermet/ed2k_recovermet-0.2_alpha1.ebuild,v 1.6 2008/04/13 21:47:35 betelgeuse Exp $

DESCRIPTION="Tool for recovering eDonkey2000 .part.met files"
HOMEPAGE="http://gentoo.mirror.at.stealer.net/files/"
SRC_URI="http://gentoo.mirror.at.stealer.net/files/${P/1/}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dobin ed2k_recovermet
	dodoc README
}
