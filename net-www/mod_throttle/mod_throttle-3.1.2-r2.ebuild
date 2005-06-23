# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_throttle/mod_throttle-3.1.2-r2.ebuild,v 1.2 2005/06/23 01:35:59 agriffis Exp $

inherit apache-module

# test target in Makefile isn't sane
RESTRICT="test"

MY_PV=${PV//./}

DESCRIPTION="Bandwidth and request throttling for Apache"
HOMEPAGE="http://www.snert.com/Software/mod_throttle/"

KEYWORDS="~x86 ~sparc ~ppc"
SRC_URI="http://www.snert.com/Software/${PN}/${PN}${MY_PV}.tgz"
DEPEND=""
LICENSE="as-is"
SLOT="0"
IUSE=""

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="THROTTLE"

need_apache1

src_install() {

	apache1_src_install

	sed 's/Img\///g' < index.shtml > index.html
	dodoc CHANGES.txt LICENSE.txt
	dohtml -r index.html Img/

}
