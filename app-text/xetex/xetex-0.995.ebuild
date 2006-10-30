# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xetex/xetex-0.995.ebuild,v 1.6 2006/10/30 20:28:05 jer Exp $

inherit eutils

DESCRIPTION="Unicode version of tex with other enhancements."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
SRC_URI="http://scripts.sil.org/svn-view/xetex/TAGS/${P}.tar.gz"

LICENSE="XeTeX"
SLOT="0"
KEYWORDS="~hppa ~ppc ~ppc64 ~sparc"
IUSE=""

RDEPEND="app-text/xdvipdfmx >=app-text/tetex-3.0"
DEPEND=">=app-text/tetex-3.0"

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
	mkdir -p ${D}usr/share/texmf-site/tex/generic
	mv ${D}usr/share/texmf/tex/generic/hyphen ${D}usr/share/texmf-site/tex/generic

}

pkg_preinst()
{
	pwd
	cd ${S}
	ln -sf ${D}usr/share/texmf-site/tex/generic/hyphen ${D}usr/share/texmf/tex/generic/hyphen
	texhash "${D}usr/share/texmf"
	sh ./rebuild-formats

	# And tidy up fmtutil's location.
	fmtutil=`kpsewhich --format="web2c files" fmtutil.cnf`
	if [ -L $fmtutil ] ; then
		fmtutil_real=`readlink "${fmtutil}"`
		mkdir -p ${D}`dirname "${fmtutil_real}"`
		mv "${D}${fmtutil}" "${D}${fmtutil_real}"
	fi

	rm ${D}usr/share/texmf/tex/generic/hyphen

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
