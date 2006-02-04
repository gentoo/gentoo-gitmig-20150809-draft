# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-client/nessus-client-1.0.0_rc4.ebuild,v 1.1 2006/02/04 01:31:21 vanquirius Exp $

MY_P="NessusClient-${PV/_rc/.RC}"
DESCRIPTION="A client for the Nessus vulnerability scanner"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="!net-analyzer/nessus-core
	dev-libs/openssl
	>=x11-libs/gtk+-2.8.8"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES README_SSL VERSION
}
