# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-bgchanger/gkrellm-bgchanger-0.0.4-r1.ebuild,v 1.1 2003/12/01 17:44:32 seemant Exp $

IUSE=""

MY_PN=gkrellmbgchg
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Plugin for GKrellM to change your desktop background"
HOMEPAGE="http://www.bender-suhl.de/stefan/english/comp/gkrellmbgchg.html"
SRC_URI="http://www.bender-suhl.de/stefan/comp/sources/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~amd64"

DEPEND="=app-admin/gkrellm-1.2*"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/lib/gkrellm/plugins
	doins ${MY_PN}.so

	dodoc README TODO
}
