# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_authenticache/mod_authenticache-2.0.8.ebuild,v 1.7 2004/09/03 23:24:08 pvdabeel Exp $

DESCRIPTION="A generic Apache2 credential caching module"
HOMEPAGE="http://killa.net/infosec/mod_authenticache/"

SRC_URI="http://killa.net/infosec/${PN}/${P}.tar.bz2"
DEPEND="virtual/libc"
RDEPEND="${DEPEND} =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc"
IUSE=""
SLOT="0"

src_compile() {
	#fix version string
	perl -pi -e "s|^#define VERSION .*|#define VERSION "\"${PV}\""|g"  defines.h || die "Version fix failed."
	sed -i 's/apxs/apxs2/g' Makefile || die "Makefile fixing failed."
	emake || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe ${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/28_mod_authenticache.conf
	dodoc ${FILESDIR}/28_mod_authenticache.conf
	newdoc ${FILESDIR}/dot-htaccess .htaccess
	newdoc ${FILESDIR}/dot-htpasswd .htpasswd
}
