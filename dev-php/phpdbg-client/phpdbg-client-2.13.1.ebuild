# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg-client/phpdbg-client-2.13.1.ebuild,v 1.2 2006/05/27 00:54:47 chtekk Exp $

KEYWORDS="~amd64 ~sparc ~x86"
DESCRIPTION="A command line client for phpdbg, suitable for use with DDD."
SRC_URI="mirror://sourceforge/dbg2/dbg-cli-${PV}${PL}-src.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"
IUSE=""

S="${WORKDIR}/dbg-cli-${PV}${PL}-src"

src_install() {
	einstall || die "install failed"

	dodoc-php AUTHORS COPYING INSTALL README TODO
}
