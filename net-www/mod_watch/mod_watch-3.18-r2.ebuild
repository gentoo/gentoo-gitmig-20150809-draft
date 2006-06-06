# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_watch/mod_watch-3.18-r2.ebuild,v 1.1 2006/06/06 09:56:00 hollow Exp $

inherit apache-module

DESCRIPTION="Bandwidth graphing for Apache with MRTG"
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
KEYWORDS="~x86"

MY_V=${PV/./}
SRC_URI="http://www.snert.com/Software/download/${PN}${MY_V}.tgz"

IUSE=""
LICENSE="as-is"
SLOT="1"

APACHE1_MOD_CONF="77_mod_watch"
APACHE1_MOD_DEFINE="WATCH"
APXS1_ARGS="-c mod_watch.c Memory.c Mutex.c Shared.c SharedHash.c NetworkTable.c"

DOCFILES="CHANGES.TXT LICENSE.TXT"

need_apache1

src_compile() {
	sed -i -e "s:/usr/local/sbin:/usr/sbin:" \
		apache2mrtg.pl || die "Path fixing failed."

	apache1_src_compile
}

src_install() {
	apache1_src_install
	dosbin apache2mrtg.pl mod_watch.pl
}
