# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.4.2c.ebuild,v 1.1 2003/12/28 00:07:01 kloeri Exp $

inherit distutils

MY_P="SPE-0.4.2.c-wx2.4.2.4.-bl2.31"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://spe.pycs.net/"
SRC_URI="http://projects.blender.org/download.php/66/${MY_P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2.3-r1
	>=dev-python/wxPython-2.4.2.4"

src_unpack() {
	unpack ${A}
	rm -fr ${S}/build/scripts*
	cd ${S}
	epatch ${FILESDIR}/spe_setup.patch
}

src_install() {
	export PREFIX="/usr"
	distutils_src_install
}

pkg_postinst() {
	SPEPATH="$PREFIX/lib/`python -c "import sys; print 'python%s.%s'%(sys.version_info[0], sys.version_info[1])"`/site-packages"

	einfo "To be able to use spe in blender, be sure that the path where spe"
	einfo "is installed ($SPEPATH) is included in your"
	einfo "PYTHONPATH environment variable. See the installation section in the manual"
	einfo "for more information ($SPEPATH/spe/doc/manual.html).\n\n"
}
