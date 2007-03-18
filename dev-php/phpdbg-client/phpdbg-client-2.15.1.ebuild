# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg-client/phpdbg-client-2.15.1.ebuild,v 1.1 2007/03/18 01:21:19 chtekk Exp $

KEYWORDS="~amd64 ~sparc ~x86"

DESCRIPTION="A command line client for phpdbg, suitable for use with DDD."
HOMEPAGE="http://dd.cron.ru/dbg/"
SRC_URI="mirror://sourceforge/dbg2/dbg-cli-${PV}-src.tar.gz"
LICENSE="dbgphp"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/dbg-cli-${PV}-src"

src_install() {
	einstall || die "einstall failed"

	dodoc-php AUTHORS COPYING INSTALL README TODO
}
