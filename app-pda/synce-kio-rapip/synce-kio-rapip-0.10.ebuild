# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kio-rapip/synce-kio-rapip-0.10.ebuild,v 1.1 2008/11/13 00:07:29 mescalinum Exp $

inherit eutils distutils

DESCRIPTION="SynCE - KDE kioslave for the SynCE RAPIP protocol"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

IUSE="arts"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND="~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"
DEPEND="${RDEPEND}
	arts? ( kde-base/arts )"

#need-kde 3.2

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

S="${WORKDIR}/synce-kio-rapip-${PV}"

src_compile() {
	econf $(use_with arts) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO ChangeLog
}

pkg_postinst() {
	einfo "To use, simply open Konqueror, Dolphin, or any other KIO-enabled file"
	einfo "manager and type in rapip://DEVICENAME/ to the address bar. If you are"
	einfo "not sure about the name of your device, simply go to rapip:/ which"
	einfo "will show the first device it finds."
}
