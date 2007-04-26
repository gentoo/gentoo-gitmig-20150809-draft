# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openc6/openc6-0.9.9.ebuild,v 1.1 2007/04/26 13:58:15 drizzt Exp $

inherit kde-functions

DESCRIPTION="An open source C6 client"
HOMEPAGE="http://openc6.sourceforge.net/"
SRC_URI="mirror://sourceforge/openc6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="kde"

DEPEND="kde? ( >=kde-base/kdelibs-3.0.0 )"

need-qt 3.1

src_compile() {
	econf || die
	emake || die

	if use kde; then
		einfo "Compiling KDE systray plugin"
		cd "${S}"/plugins/kdegui
		econf --without-arts --prefix="${ROOT}"/usr/share/OpenC6 || die
		emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use kde; then
		cd "${S}"/plugins/kdegui
		emake DESTDIR="${D}" install || die
	fi
}
