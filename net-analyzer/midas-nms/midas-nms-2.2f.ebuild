# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/midas-nms/midas-nms-2.2f.ebuild,v 1.1 2004/10/20 14:17:46 bass Exp $

inherit webapp

S="${WORKDIR}/MIDAS-${PV}"
DESCRIPTION="Monitoring, Intrusion Detection, Administration System"
SRC_URI="mirror://sourceforge/midas-nms/MIDAS-${PV}.tar.gz"
HOMEPAGE="http://midas-nms.sf.net"
LICENSE="MIT"

KEYWORDS="~x86"

DEPEND="dev-db/mysql
	net-libs/libpcap
	net-www/webapp-config
	media-libs/gd"
RDEPEND="net-www/apache
	dev-php/mod_php"

pkg_setup() {
	webapp_pkg_setup
}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	webapp_src_preinst

	make DESTDIR=${D} install || die

	dodir /usr/share/midas-nms
	dodir /usr/share/midas-nms/sql
	insinto /usr/share/midas-nms/sql
	doins sql/* /usr/share/midas-nms/sql/

	# web
	cp -r MIDAS/* ${D}${MY_HTDOCSDIR}/
	webapp_serverowned ${MY_HTDOCSDIR}
	webapp_src_install

	# Install documentation.
	dodoc COPYING
	dodoc docs/CHANGELOG
	dodoc docs/INSTALL.txt
}

pkg_postinst() {
	webapp_pkg_postinst
	chown -R :apache /var/www/localhost/htdocs/midas-nms/{inc/config,php-graph}
	chmod g+w /var/www/localhost/htdocs/midas-nms/{inc/config,php-graph}
	cp ${FILESDIR}/install.php /var/www/localhost/htdocs/midas-nms/install

	einfo
	einfo "To install the web interface go to:"
	einfo "http://localhost/midas-nms/install/install.php"
	einfo
	einfo "The conf files are located in /usr/etc/MIDAS*.cf.dist"
	einfo "Please read INSTALL.txt for more info."
	einfo
}
