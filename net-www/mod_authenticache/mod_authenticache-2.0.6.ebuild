# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_authenticache/mod_authenticache-2.0.6.ebuild,v 1.4 2004/04/04 22:29:46 zul Exp $

DESCRIPTION="A generic Apache2 credential caching module"
HOMEPAGE="http://original.killa.net/infosec/mod_authenticache/"

S=${WORKDIR}/${P}
SRC_URI="http://original.killa.net/infosec/${PN}/${P}.tar.bz2"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND} =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	#fix version string
	perl -pi -e "s|^#define VERSION .*|#define VERSION \"${PV}\"|g" \
		defines.h
	apxs2 -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/28_mod_authenticache.conf
	dodoc ${FILESDIR}/28_mod_authenticache.conf
	newdoc ${FILESDIR}/dot-htaccess .htaccess
	newdoc ${FILESDIR}/dot-htpasswd .htpasswd
}
