# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.5.1f-r1.ebuild,v 1.2 2005/10/14 22:45:03 halcy0n Exp $

inherit distutils eutils

MY_P="SPE-0.5.1.f-wx2.4.2.4.-bl2.31"
#MY_P2="SPE-0.5.1.d-wx2.4.2.4.-bl2.31"
DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://spe.pycs.net/"
SRC_URI="http://projects.blender.org/download.php/162/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
# Upstream have mismatched versions when unpacked..
S="${WORKDIR}/${MY_P/1.f/1.d}"

DEPEND=">=virtual/python-2.2.3-r1"

RDEPEND=">=dev-python/wxpython-2.4.2.4
	>=dev-util/wxglade-0.3.2
	>=dev-python/pychecker-0.8.13
	${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/spe_setup.patch || die "patch failed."
	epatch ${FILESDIR}/spe-0.5-wxversion.patch
	# fix bug 108538
	chmod -R go-w ${S}/*
}

src_install() {
	distutils_src_install
	distutils_python_version
	SITEPATH="/usr/lib/python${PYVER}/site-packages"

	dobin spe
	rm -rf "${D}${SITEPATH}/_spe/plugins/wxGlade"
	rm -rf "${D}${SITEPATH}/_spe/plugins/pychecker"
	ln -svf "../../wxglade" "${D}${SITEPATH}/_spe/plugins/wxGlade"
	dodir "${SITEPATH}/wxglade"
	touch "${D}${SITEPATH}/wxglade/__init__.py"
	ln -svf "../../pychecker" "${D}${SITEPATH}/_spe/plugins/pychecker"
}

pkg_postinst() {
	distutils_python_version
	SPEPATH="/usr/lib/python${PYVER}/site-packages"

	einfo
	einfo "To be able to use spe in blender, be sure that the path where spe is"
	einfo "installed ($SPEPATH) is included in your PYTHONPATH"
	einfo "environment variable. See the installation section in the manual for"
	einfo "more information ($SPEPATH/_spe/doc/manual.pdf)."
	einfo
}
