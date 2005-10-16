# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg-client/phpdbg-client-2.11.32.ebuild,v 1.2 2005/10/16 05:10:58 weeve Exp $

S="${WORKDIR}/dbg_client-${PV}${PL}"

IUSE=""
DESCRIPTION="A command line client for phpdbg, suitable for use with DDD."
SRC_URI="mirror://sourceforge/dbg2/dbg-cli-${PV}${PL}-src.tar.gz"
HOMEPAGE="http://dd.cron.ru/dbg/"
LICENSE="dbgphp"
SLOT="0"

KEYWORDS="~sparc ~x86"

src_install() {
	einstall || die "install failed"

	dodoc AUTHORS COPYING INSTALL README TODO
}
