# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pilot-mailsync/pilot-mailsync-0.8.1.ebuild,v 1.2 2004/07/24 20:51:37 liquidx Exp $

DESCRIPTION="An application to transfer outgoing mail from and deliver incoming mail to a Palm OS device."
HOMEPAGE="http://wissrech.iam.uni-bonn.de/people/garcke/pms/"
SRC_URI="http://wissrech.iam.uni-bonn.de/people/garcke/pms/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
	>=app-pda/pilot-link-0.11.7-r1"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {

	econf $(use_enable ssl) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README INSTALL docs/*
}
