# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_security/mod_security-1.7.6.ebuild,v 1.6 2004/10/19 03:10:11 weeve Exp $

DESCRIPTION="Intrusion Detection System for apache"
HOMEPAGE="http://www.modsecurity.org"
SRC_URI="http://www.modsecurity.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE="apache2 doc"
DEPEND="apache2? ( =net-www/apache-2* )
	!apache2? ( =net-www/apache-1* )"

src_compile() {
	use apache2 || apxs -S LIBEXECDIR=${S} -ci ${S}/apache1/mod_security.c
	use apache2 && apxs2 -S LIBEXECDIR=${S} -ci ${S}/apache2/mod_security.c
}

src_install() {
	use apache2 || exeinto /usr/lib/apache-extramodules/
	use apache2 && exeinto /usr/lib/apache2-extramodules/
	doexe ${S}/mod_security.so
	dodoc CHANGES httpd.conf.example-full httpd.conf.example-minimal INSTALL LICENSE README
	use doc && dodoc modsecurity-manual-1.7.4.pdf

	if use apache2; then
		einfo "Installing a Apache2 config for mod_security (99_mod_security.conf)"
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/99_mod_security.conf
	else
		einfo "Installing a Apache config for mod_security (mod_security.conf)"
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_security.conf
	fi
}
