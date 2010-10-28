# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh-installkeys/ssh-installkeys-1.4.ebuild,v 1.2 2010/10/28 11:09:30 ssuominen Exp $

DESCRIPTION="Script to install ssh keys on local and remote servers."
HOMEPAGE="http://www.catb.org/~esr/ssh-installkeys"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/python-2.3"

src_install() {
	doman ${PN}.1
	dodoc README ${PN}.spec ${PN}.xml
	dobin ${PN}
}
