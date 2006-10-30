# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xetex/xetex-0.995.ebuild,v 1.3 2006/10/30 00:55:21 joslwah Exp $

inherit eutils

DESCRIPTION="Unicode version of tex with other enhancements."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
SRC_URI="http://scripts.sil.org/svn-view/xetex/TAGS/${P}.tar.gz"

LICENSE="XeTeX"
SLOT="0"
KEYWORDS="~ppc64 ~sparc"
IUSE=""

RDEPEND="app-text/xdvipdfmx app-text/tetex"
DEPEND="app-text/tetex"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-install.patch"
	epatch "${FILESDIR}/${P}-rebuild.patch"
}

src_compile() {
	sh build-xetex || die
}

src_install() {
	sh -x install-xetex || die

	# Need to softlink xelatex to xetex.
	cd ${D}/usr/bin
	ln -s xetex xelatex
}

pkg_preinst()
{
	fmtutil=`kpsewhich --format="web2c files" fmtutil.cnf`
	if [ -L $fmtutil ] ; then
		fmtutil_real=`readlink "${fmtutil}"`
		mkdir -p ${D}`dirname "${fmtutil_real}"`
		mv "${D}${fmtutil}" "${D}${fmtutil_real}"
	fi
}

pkg_postinst()
{
	texhash
	return
}

pkg_postrm()
{
	texhash
	return
}
