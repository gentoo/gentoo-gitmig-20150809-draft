# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_midgard-preparse/mod_midgard-preparse-1.5.0.ebuild,v 1.1 2004/09/22 10:57:23 rl03 Exp $

inherit webapp

DESCRIPTION="Apache preparser module for Midgard"
HOMEPAGE="http://www.midgard-project.org/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-543303d5b45265b6206a908e3bf6dae1/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=www-apps/midgard-lib-${PV}
	=net-www/apache-1*
"
RDEPEND="
	${DEPEND}
	>=www-apps/midgard-php4-${PV}
	>=www-apps/midgard-data-${PV}
"

pkg_setup() {
	webapp_pkg_setup
	einfo "Make a backup of your database!"
}

src_compile() {
	econf --with-apxs=/usr/sbin/apxs || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst
	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	insinto /usr/lib/apache
	doins mod_midgard.so
	cp midgard-root.php ${D}/${MY_HOSTROOTDIR}
	webapp_src_install
}

pkg_postinst() {
	einfo "Add the following to your /etc/apache/conf/apache.conf"
	einfo "LoadModule midgard_module modules/mod_midgard.so"
	einfo "AddModule mod_midgard.c"
	einfo "Include /etc/apache/conf/addon-modules/midgard-data.conf"
	einfo
	einfo "run database-upgrade included in midgard-data to create cache tables"
	einfo "Add the MidgardPageCacheDir directive to your apache configuration"
	einfo "see /usr/share/doc/${P}/INSTALL.gz for more info"
	einfo "note that midgard-data will provide a config file for you"
	webapp_pkg_postinst
}
