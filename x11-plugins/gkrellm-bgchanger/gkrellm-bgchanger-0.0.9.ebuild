# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bgchanger/gkrellm-bgchanger-0.0.9.ebuild,v 1.2 2004/02/17 07:55:06 mr_bones_ Exp $

IUSE=""

MY_PN=gkrellmbgchg2
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Plugin for GKrellM2 to change your desktop background"
HOMEPAGE="http://www.bender-suhl.de/stefan/english/comp/gkrellmbgchg.html"
SRC_URI="http://www.bender-suhl.de/stefan/comp/sources/${MY_P}.tar.gz"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins ${MY_PN/2/}.so

	dodoc ChangeLog README TODO
}
