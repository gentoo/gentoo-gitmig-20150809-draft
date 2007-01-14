# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_watch/mod_watch-3.18-r2.ebuild,v 1.2 2007/01/14 21:31:33 chtekk Exp $

inherit apache-module

KEYWORDS="x86"

DESCRIPTION="Bandwidth graphing module for Apache1 with MRTG."
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
SRC_URI="http://www.snert.com/Software/download/${PN}${PV/./}.tgz"
LICENSE="as-is"
SLOT="1"
IUSE=""

DEPEND=""
RDEPEND=""

APXS1_ARGS="-c ${PN}.c Memory.c Mutex.c Shared.c SharedHash.c NetworkTable.c"

APACHE1_MOD_CONF="77_mod_watch"
APACHE1_MOD_DEFINE="WATCH"

DOCFILES="CHANGES.TXT LICENSE.TXT"

need_apache1

src_compile() {
	sed -i -e "s:/usr/local/sbin:/usr/sbin:" \
		apache2mrtg.pl || die "Path fixing failed"

	apache1_src_compile
}

src_install() {
	apache1_src_install
	dosbin apache2mrtg.pl mod_watch.pl
	keepdir "${ROOT}"/var/lib/${PN}
}
