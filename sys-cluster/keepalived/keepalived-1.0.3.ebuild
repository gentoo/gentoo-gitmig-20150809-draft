# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.0.3.ebuild,v 1.4 2003/08/18 23:07:30 iggy Exp $

DESCRIPTION="The main goal of the keepalived project is to add a strong & robust keepalive facility to the Linux Virtual Server project."
HOMEPAGE="http://keepalived.sourceforge.net"
LICENSE="GPL-2"
DEPEND="dev-libs/popt"

SRC_URI="http://keepalived.sourceforge.net/software/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P}"

src_compile() {
	cd "${S}"
	./configure --prefix=/
	make || die
}

src_install() {

	cd "${S}"
	einstall	

	exeinto /etc/init.d
	newexe ${FILESDIR}/init-keepalived keepalived

	dodoc doc/* doc/samples/*

}

pkg_postinst() {

	einfo ""
	einfo "If you want Linux Virtual Server support in"
	einfo "keepalived then you must emerge an LVS patched" 
	einfo "kernel like gentoo-sources, compile with ipvs"
	einfo "support either as a module or built into the"
	einfo "kernel, emerge the ipvsadm userland tools,"
	einfo "and reemerge keepalived."
	einfo ""

}
