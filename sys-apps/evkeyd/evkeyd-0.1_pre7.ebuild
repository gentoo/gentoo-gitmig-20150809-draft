# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/evkeyd/evkeyd-0.1_pre7.ebuild,v 1.4 2005/02/13 05:16:47 vapier Exp $

MY_PV=${PV/_/}
DESCRIPTION="Input event layer media key activator"
HOMEPAGE="http://www.stampflee.com/evkeyd/"
SRC_URI="http://www.stampflee.com/evkeyd/downloads/evkeyd-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}-${MY_PV}

src_install() {
	dosbin evkeyd || die
	insinto /etc
	doins evkeyd.conf
	newinitd ${FILESDIR}/evkeyd.rc evkeyd
}
