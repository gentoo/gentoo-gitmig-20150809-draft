# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_throttle/mod_throttle-3.1.2-r2.ebuild,v 1.6 2007/01/14 21:02:05 chtekk Exp $

inherit apache-module

KEYWORDS="ppc sparc x86"

DESCRIPTION="Bandwidth and request throttling for Apache1."
HOMEPAGE="http://www.snert.com/Software/mod_throttle/"
SRC_URI="http://www.snert.com/Software/${PN}/${PN}${PV//./}.tgz"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

# Test target in Makefile isn't sane
RESTRICT="test"

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="THROTTLE"

need_apache1

src_install() {
	apache1_src_install

	sed 's/Img\///g' < index.shtml > index.html
	dodoc CHANGES.txt LICENSE.txt
	dohtml -r index.html Img/
}
