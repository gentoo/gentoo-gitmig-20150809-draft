# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_tcl/mod_tcl-1.0.1.ebuild,v 1.4 2007/01/15 19:28:38 chtekk Exp $

inherit apache-module

KEYWORDS="ppc x86"

DESCRIPTION="An Apache2 module providing an embedded Tcl interpreter."
HOMEPAGE="http://tcl.apache.org/mod_tcl/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c -Wl,-ltcl -DHAVE_TCL_H ${PN}.c tcl_cmds.c tcl_misc.c"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="TCL"

DOCFILES="AUTHORS INSTALL NEWS README test_script.tm"

need_apache2

src_compile() {
	mv -f "tcl_core.c" "${PN}.c"
	apache2_src_compile
}
