# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kio-rapip/synce-kio-rapip-0.10-r1.ebuild,v 1.1 2008/12/14 17:02:30 mescalinum Exp $

inherit distutils eutils qt3

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
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog # TODO
}

pkg_postinst() {
	elog "To use, simply open Konqueror, Dolphin, or any other KIO-enabled file"
	elog "manager and type in rapip://DEVICENAME/ to the address bar. If you are"
	elog "not sure about the name of your device, simply go to rapip:/ which"
	elog "will show the first device it finds."
}
