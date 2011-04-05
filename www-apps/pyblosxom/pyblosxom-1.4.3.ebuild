# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/pyblosxom/pyblosxom-1.4.3.ebuild,v 1.2 2011/04/05 05:38:06 ulm Exp $

inherit eutils distutils webapp

DESCRIPTION="PyBlosxom is a lightweight weblog system."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://pyblosxom.sourceforge.net/"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

# This installs python library files.
SLOT=0
WEBAPP_MANUAL_SLOT=yes

IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A} && cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.4.2-gentoo.patch || die "Patching failed!"

}

src_install() {
	webapp_src_preinst

	distutils_src_install
	dodoc README

	keepdir /usr/share/${P}/plugins
	keepdir "${MY_HTDOCSDIR}"/data
	keepdir "${MY_HTDOCSDIR}"/log

	mkdir -p "${D}${MY_CGIBINDIR}"/pyblosxom
	cp web/{config.py,pyblosxom.cgi} "${D}${MY_CGIBINDIR}"/pyblosxom/

	webapp_configfile  "${MY_CGIBINDIR}"/pyblosxom/config.py

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt
	webapp_hook_script "${FILESDIR}"/config-hook.sh

	webapp_src_install
}
