# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moinmoin/moinmoin-1.5.3.ebuild,v 1.1 2006/04/23 21:27:24 rl03 Exp $

inherit webapp

MY_PN="moin"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="Python WikiClone"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://moin.sourceforge.net"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE="rss"

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}
	>=dev-python/docutils-0.4
	rss? ( >=dev-python/pyxml-0.8.4 )"

src_compile() {
	python setup.py build || die "python build failed"
}

src_install () {
	webapp_src_preinst

	python setup.py install --root=${D} --prefix=/usr install || die "python install failed"

	dodoc ChangeLog README docs/CHANGES* docs/HACKS docs/README.migration
	dohtml docs/INSTALL.html
	dodir ${MY_HOSTROOTDIR}/${PF}

	cd ${D}/usr/share/moin
	cp -r htdocs/* server/moin.cgi ${D}/${MY_HTDOCSDIR}
	chmod +x ${D}/${MY_HTDOCSDIR}/moin.cgi
	cp -r data underlay config/wikiconfig.py ${D}/${MY_HOSTROOTDIR}/${PF}
	cp -r config ${D}/${MY_HOSTROOTDIR}/${PF}/altconfigs
	cp -r server ${D}/${MY_HOSTROOTDIR}/${PF}/altserver

	# data needs to be serverowned per moin devs
	cd ${D}/${MY_HOSTROOTDIR}/${PF}
	for file in $(find data underlay); do
		webapp_serverowned "${MY_HOSTROOTDIR}/${PF}/${file}"
	done

	webapp_configfile ${MY_HOSTROOTDIR}/${PF}/wikiconfig.py
	webapp_hook_script ${FILESDIR}/reconfig-2
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	ewarn "If you are upgrading from 1.3.x, please read"
	ewarn "/usr/share/doc/${PF}/README.migration.gz"
	ewarn "and http://moinmoin.wikiwikiweb.de/HelpOnUpdating"
	webapp_pkg_postinst
}
