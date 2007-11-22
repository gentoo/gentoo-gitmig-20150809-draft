# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vsound/vsound-0.6-r1.ebuild,v 1.3 2007/11/22 17:55:59 cla Exp $

inherit eutils

DESCRIPTION="A virtual audio loopback cable"
HOMEPAGE="http://www.vsound.org"
SRC_URI="http://www.vsound.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=media-sound/sox-12.17.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-stdout.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS Changelog NEWS README
}

pkg_postinst() {
	elog
	elog "To use this program to, for instance, record audio from realplayer:"
	elog "vsound realplay realmediafile.rm"
	elog
	elog "Or, to listen to realmediafile.rm at the same time:"
	elog "vsound -d realplay realmediafile.rm"
	elog
	elog "See ${HOMEPAGE} or /usr/share/doc/${PF}/README.bz2 for more info"
	elog
}
