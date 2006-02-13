# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/pyblosxom/pyblosxom-1.3.2.ebuild,v 1.1 2006/02/13 18:33:07 wrobel Exp $

inherit eutils distutils webapp

DESCRIPTION="PyBlosxom is a lightweight weblog system."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://pyblosxom.sourceforge.net/"

LICENSE="MIT"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/python"

src_unpack() {

	unpack ${A} && cd "${S}"

	epatch ${FILESDIR}/${P}-gentoo.patch || die "Patching failed!"

}

src_install() {
	webapp_src_preinst

	distutils_src_install
	dodoc README

	keepdir /usr/share/${P}/plugins
	keepdir ${MY_HTDOCSDIR}/data
	keepdir ${MY_HTDOCSDIR}/log

	mkdir -p ${D}${MY_CGIBINDIR}/pyblosxom
	cp web/{config.py,pyblosxom.cgi} ${D}${MY_CGIBINDIR}/pyblosxom/

	webapp_configfile  ${MY_CGIBINDIR}/pyblosxom/config.py

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade-en.txt
	webapp_hook_script ${FILESDIR}/config-hook.sh

	webapp_src_install
}
