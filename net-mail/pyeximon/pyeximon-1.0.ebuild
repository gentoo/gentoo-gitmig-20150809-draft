# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pyeximon/pyeximon-1.0.ebuild,v 1.1 2004/10/26 23:04:49 slarti Exp $

DESCRIPTION="A GNOME monitor/manager for the popular MTA, Exim."
HOMEPAGE="http://pyeximon.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyeximon/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND=""
RDEPEND="mail-mta/exim
	>=dev-lang/python-2.1
	dev-python/rtgraph
	=dev-python/pygtk-2*"

src_compile() {
	einfo "Nothing to compile."
}
src_install() {
	exeinto /usr/sbin
	doexe pyeximon

	insinto /etc
	doins pyeximon.conf

	doman pyeximon.8
	dodoc README
}
