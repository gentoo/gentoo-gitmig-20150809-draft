# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethloop/ethloop-10.ebuild,v 1.3 2004/08/16 10:17:30 eldad Exp $

DESCRIPTION="Local simulator for testing Linux QoS disciplines"
HOMEPAGE="http://luxik.cdi.cz/~devik/qos/ethloop/"
SRC_URI="http://luxik.cdi.cz/~devik/qos/ethloop/ethloop10.tgz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin ${S}/ethloop
}
