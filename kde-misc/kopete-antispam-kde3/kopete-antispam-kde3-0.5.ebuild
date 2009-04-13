# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-antispam-kde3/kopete-antispam-kde3-0.5.ebuild,v 1.1 2009/04/13 18:17:41 hwoarang Exp $

EAPI="1"
inherit kde

DESCRIPTION="Antispam filter for Kopete instant messenger."
HOMEPAGE="http://kopeteantispam.sourceforge.net"
SRC_URI="mirror://sourceforge/kopeteantispam/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="arts"

DEPEND="kde-base/kopete:3.5"
RDEPEND="${DEPEND}"
need-kde 3.5

src_compile() {
	myconf="${myconf} --prefix=/usr/kde/3.5 $(use_with arts)"
	kde_src_compile
}

pkg_postinst() {
	elog "You can now enable and set up the Antispam plugin in Kopete."
	elog "It can be reached in the Kopete Plugin dialog."
}
