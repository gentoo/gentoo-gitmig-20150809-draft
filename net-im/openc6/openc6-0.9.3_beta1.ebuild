# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openc6/openc6-0.9.3_beta1.ebuild,v 1.1 2003/10/16 03:36:06 lu_zero Exp $

inherit kde-base

need-kde 3.1
need-qt 3.1

MY_PV=${PV/_beta/-}_beta
DESCRIPTION="OpenC6, a free C6 client."
HOMEPAGE="http://openc6.sourceforge.net/"
SRC_URI="mirror://sourceforge/openc6/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
