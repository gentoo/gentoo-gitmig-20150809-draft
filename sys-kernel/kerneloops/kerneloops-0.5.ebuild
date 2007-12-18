# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kerneloops/kerneloops-0.5.ebuild,v 1.1 2007/12/18 17:23:33 gregkh Exp $

inherit eutils

DESCRIPTION="Tool to automatically collect and submit Linux kernel crash signatures"
HOMEPAGE="http://www.kerneloops.org/"
SRC_URI="http://www.kerneloops.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
