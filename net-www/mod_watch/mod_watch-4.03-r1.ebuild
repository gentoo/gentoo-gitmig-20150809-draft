# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_watch/mod_watch-4.03-r1.ebuild,v 1.1 2005/01/09 12:20:14 hollow Exp $

inherit eutils apache-module

MY_V=${PV/./}

DESCRIPTION="Bandwidth graphing for Apache with MRTG"
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
SRC_URI="http://www.snert.com/Software/download/${PN}${MY_V}.tgz"

KEYWORDS="~x86 ~ppc"
DEPEND=">=sys-apps/sed-4"
LICENSE="as-is"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}-4.3"

APACHE2_MOD_CONF="77_mod_watch"
APACHE2_MOD_DEFINE="WATCH"

src_compile() {
	sed -i \
		-e "s:APXS=\\(.*\\):APXS=${APXS2} # \\1:" \
		-e "s:APACHECTL=\\(.*\\):APACHECTL=${APACHECTL2} # \\1:" \
		Makefile.dso || die "Path fixing failed."

	emake -f Makefile.dso build || die "Make failed."
}

src_install() {
	apache2_src_install
	dosbin apache2mrtg.pl mod_watch.pl Contrib/mod_watch_list.pl
	dodoc *.shtml CHANGES.TXT LICENSE.TXT Contrib/*.txt
	dodir /var/lib/mod_watch
}
