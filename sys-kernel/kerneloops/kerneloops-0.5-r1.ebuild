# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/kerneloops/kerneloops-0.5-r1.ebuild,v 1.1 2007/12/18 22:22:51 gregkh Exp $

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

	doinitd "${FILESDIR}"/kerneloops || die "doinitd failed"

}

pkg_postinst() {
	ewarn "Be careful, you need to edit the /etc/kerneloops.org config file to"
	ewarn "be able to successfully run this program.  It is still very raw, and"
	ewarn "you need to be aware of the potential information that you could"
	ewarn "send to the world when running this program."
	ewarn ""
	ewarn "You have been warned, use at your own risk!"
}
