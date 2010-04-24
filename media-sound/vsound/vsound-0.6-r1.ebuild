# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vsound/vsound-0.6-r1.ebuild,v 1.5 2010/04/24 16:54:19 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A virtual audio loopback cable"
HOMEPAGE="http://www.vsound.org/"
SRC_URI="http://www.vsound.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND=">=media-sound/sox-14.2.0"

src_prepare() {
	epatch "${FILESDIR}"/${P}-stdout.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die

	find "${D}" -name '*.la' -delete
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
