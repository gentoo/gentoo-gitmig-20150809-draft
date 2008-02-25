# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moinmoin/moinmoin-1.6.1.ebuild,v 1.5 2008/02/25 15:11:57 beandog Exp $

MY_PN="moin"
PYTHON_MODNAME="MoinMoin"
inherit webapp distutils

DESCRIPTION="Python WikiClone"
SRC_URI="http://static.moinmo.in/files/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://moinmo.in/"

KEYWORDS="amd64 ppc sparc x86"
LICENSE="GPL-2"
IUSE="rss"
SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}
	virtual/httpd-cgi
	>=dev-python/docutils-0.4
	rss? ( >=dev-python/pyxml-0.8.4 )"
S=${WORKDIR}/${MY_PN}-${PV}

src_install () {
	webapp_src_preinst

	distutils_src_install

	dodoc README docs/CHANGES* docs/HACKS docs/README.migration
	dohtml docs/INSTALL.html
	dodir "${MY_HOSTROOTDIR}/${PF}"

	cd "${D}/usr/share/moin"
	cp -r htdocs/* server/moin.cgi "${D}/${MY_HTDOCSDIR}"
	chmod +x "${D}/${MY_HTDOCSDIR}/moin.cgi"
	cp -r data underlay config/wikiconfig.py "${D}/${MY_HOSTROOTDIR}/${PF}"
	cp -r config "${D}/${MY_HOSTROOTDIR}/${PF}/altconfigs"
	cp -r server "${D}/${MY_HOSTROOTDIR}/${PF}/altserver"

	# data needs to be serverowned per moin devs
	cd "${D}/${MY_HOSTROOTDIR}/${PF}"
	for file in $(find data underlay); do
		webapp_serverowned "${MY_HOSTROOTDIR}/${PF}/${file}"
	done

	webapp_configfile "${MY_HOSTROOTDIR}/${PF}/wikiconfig.py"
	webapp_hook_script "${FILESDIR}/reconfig-2"
	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"

	webapp_src_install
}

pkg_postinst() {
	ewarn "If you are upgrading from 1.3.x, please read"
	ewarn "README.migration in /usr/share/doc/${PF}"
	ewarn "and http://moinmoin.wikiwikiweb.de/HelpOnUpdating"

	distutils_pkg_postinst
	webapp_pkg_postinst
}
