# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_gzip/mod_gzip-1.3.26.1a.ebuild,v 1.9 2004/09/03 23:24:08 pvdabeel Exp $

DESCRIPTION="Apache module which acts as an Internet Content Accelerator"
HOMEPAGE="http://sourceforge.net/projects/mod-gzip/"
KEYWORDS="x86 sparc ~alpha ppc"

SRC_URI="mirror://sourceforge/mod-gzip/mod_gzip-${PV}.tgz"

DEPEND="=net-www/apache-1* >=sys-libs/zlib-1.1.4"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

src_compile() {
	APXS="/usr/sbin/apxs" make || die "Make failed"
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe mod_gzip.so

	insinto /etc/apache/conf/addon-modules
	newins ${FILESDIR}/mod_gzip.conf-new mod_gzip.conf

	dohtml -r docs/manual/english
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_gzip.so mod_gzip.c gzip_module \
		define=GZIP addconf=conf/addon-modules/mod_gzip.conf
	:;
}
