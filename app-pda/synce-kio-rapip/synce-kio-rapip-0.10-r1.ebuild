# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kio-rapip/synce-kio-rapip-0.10-r1.ebuild,v 1.3 2009/11/06 19:01:23 ssuominen Exp $

inherit distutils eutils qt3

DESCRIPTION="SynCE - KDE kioslave for the SynCE RAPIP protocol"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-pda/synce-libsynce
	app-pda/synce-librapi2"

S=${WORKDIR}/synce-kio-rapip-${PV}

src_compile() {
	econf \
		--without-arts
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog # TODO
}

pkg_postinst() {
	elog "To use, simply open Konqueror, Dolphin, or any other KIO-enabled file"
	elog "manager and type in rapip://DEVICENAME/ to the address bar. If you are"
	elog "not sure about the name of your device, simply go to rapip:/ which"
	elog "will show the first device it finds."
}
