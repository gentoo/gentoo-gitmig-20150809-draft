# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/midgard-data/midgard-data-1.5.0.ebuild,v 1.1 2004/09/22 10:54:25 rl03 Exp $

inherit webapp

DESCRIPTION="MySQL data for the Midgard framework"
HOMEPAGE="http://www.midgard-project.org/"
SRC_URI="http://www.midgard-project.org/midcom-serveattachmentguid-5a9fab1f64a6025fd40ad215ddf1bb1f/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=www-apps/midgard-lib-${PV}
	dev-db/mysql
"
src_unpack() {
	unpack ${A}
	cd ${S}
	#blobdir will be created by the wrapper
	sed -e "s|mkdir -pi @BLOBDIR@|#mkdir -p @BLOBDIR@|" -i dbinstall.in
}
src_compile() {
	:;
}

src_install() {
	webapp_src_preinst
	dodoc INSTALL README* GUIDSforOLDSITE.sql
	dodir /usr/share/${P}
	cp -R A* [[:lower:]]* ${D}/usr/share/${P}
	cp ${FILESDIR}/wrapper-${PV}.sh ${D}/usr/share/${P}
	mv ${D}/usr/share/${P}/images/* ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/usr/share/${P}/images/
	webapp_src_install
}

pkg_postinst() {
	einfo "You now need to run"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to configure the database"
	einfo "Note that the bundled asgard is currently broken"
	einfo "consider emerging www-apps/asgard"
	einfo
	einfo "Edit /etc/repligard.conf and set DB settings and your blobdir"
	webapp_pkg_postinst
}

pkg_config() {
	bash ${ROOT}/usr/share/${P}/wrapper-${PV}.sh
}
