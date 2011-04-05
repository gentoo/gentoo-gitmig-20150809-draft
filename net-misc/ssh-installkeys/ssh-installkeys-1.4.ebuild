# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh-installkeys/ssh-installkeys-1.4.ebuild,v 1.3 2011/04/05 05:52:25 ulm Exp $

DESCRIPTION="Script to install ssh keys on local and remote servers."
HOMEPAGE="http://www.catb.org/~esr/ssh-installkeys"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"

src_install() {
	doman ${PN}.1
	dodoc README ${PN}.spec ${PN}.xml
	dobin ${PN}
}
