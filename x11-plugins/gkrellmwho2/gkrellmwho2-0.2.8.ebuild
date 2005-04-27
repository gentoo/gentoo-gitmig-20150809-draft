# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmwho2/gkrellmwho2-0.2.8.ebuild,v 1.5 2005/04/27 18:25:04 herbs Exp $

inherit multilib

IUSE=""
S=${WORKDIR}/${P}.orig
DESCRIPTION="This plugin displays currently logged in users in the scrolling line. It also shows number of logins for each username and may show idle status"
SRC_URI="http://shisha.spb.ru/debian/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://shisha.spb.ru/projects/GkrellmWHO2"

DEPEND=">=app-admin/gkrellm-2*"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

src_compile() {
# Eh? --slarti
#	pwd
#	ls
	econf || die
	emake || die
}

src_install () {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkrellmwho2.so
	dodoc README ChangeLog COPYING
}
