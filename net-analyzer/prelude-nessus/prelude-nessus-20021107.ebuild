# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prelude-nessus/prelude-nessus-20021107.ebuild,v 1.4 2004/08/03 12:00:33 dholm Exp $
DESCRIPTION="Nessus Correlation support for Prelude-IDS"
HOMEPAGE="http://www.rstack.org/oudot/prelude/correlation/"

MY_P="${P/nessus/correlation}"

SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_install() {
	dobin *.pl
	dodoc CORRELATION_README EXAMPLES NEWS vuln.conf_example
}
