# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_tcl/mod_tcl-1.0.ebuild,v 1.4 2004/04/05 01:12:26 zul Exp $

inherit eutils

DESCRIPTION="An Apache2 DSO providing an embedded Tcl interpreter"
HOMEPAGE="http://tcl.apache.org/mod_tcl/"

S=${WORKDIR}/${P}
SRC_URI="mirror://gentoo/${P}.tar.bz2"
DEPEND="dev-lang/tcl =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	mv tcl_core.c ${PN}.c
	apxs2 -c -Wl,-ltcl -DHAVE_TCL_H ${PN}.c tcl_cmds.c tcl_misc.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/27_mod_tcl.conf
	dodoc ${FILESDIR}/27_mod_tcl.conf
	dodoc AUTHORS INSTALL NEWS README test_script.tm
}
