# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_tcl/mod_tcl-1.0.1.ebuild,v 1.2 2006/10/20 04:49:05 tsunam Exp $

inherit eutils apache-module

DESCRIPTION="An Apache2 DSO providing an embedded Tcl interpreter"
HOMEPAGE="http://tcl.apache.org/mod_tcl/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
KEYWORDS="~ppc x86"
IUSE=""
SLOT="0"

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c -Wl,-ltcl -DHAVE_TCL_H ${PN}.c tcl_cmds.c tcl_misc.c"
APACHE2_MOD_CONF="1.0-r1/27_mod_tcl"
APACHE2_MOD_DEFINE="TCL"

DOCFILES="AUTHORS INSTALL NEWS README test_script.tm"

need_apache2

src_compile() {
	mv tcl_core.c ${PN}.c
	apache2_src_compile
}
