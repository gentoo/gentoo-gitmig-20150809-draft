# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moinmoin/moinmoin-1.2.3-r1.ebuild,v 1.1 2004/08/27 22:04:04 rl03 Exp $

inherit webapp

PN0="moin"
S=${WORKDIR}/${PN0}-${PV}

DESCRIPTION="Python WikiClone"
SRC_URI="http://download.sourceforge.net/${PN0}/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://moin.sourceforge.net"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

src_compile() {
	python setup.py build || die "python build failed"
}

src_install () {
	webapp_src_preinst

	python setup.py install --root=${D} --prefix=/usr install || die "python install failed"

	cd ${D}/usr/share/moin
	cp -r data htdocs/* cgi-bin/* ${D}/${MY_HTDOCSDIR}
	cd ${D}/${MY_HTDOCSDIR}

	# data needs to be serverowned per moin devs
	for file in `find data`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done
	chmod +x moin.cgi

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
