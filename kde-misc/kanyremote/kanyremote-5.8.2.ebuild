# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kanyremote/kanyremote-5.8.2.ebuild,v 1.2 2009/04/26 11:43:22 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="KDE frontend to Anyremote"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/anyremote/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth"

DEPEND=">=net-misc/anyremote-4.4[bluetooth=]
	 >=dev-python/PyQt-3.17
	 >=dev-python/pykde-3.16
	 bluetooth? ( dev-python/pybluez )"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	make_desktop_entry ${PN} ${PN} ${PN}.png "Network;RemoteAccess"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
