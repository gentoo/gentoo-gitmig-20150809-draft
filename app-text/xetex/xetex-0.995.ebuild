# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xetex/xetex-0.995.ebuild,v 1.10 2007/03/26 11:20:46 armin76 Exp $

inherit eutils

DESCRIPTION="Unicode version of tex with other enhancements."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
SRC_URI="http://scripts.sil.org/svn-view/xetex/TAGS/${P}.tar.gz"

LICENSE="XeTeX"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
	mv ${D}usr/share/texmf-site/tex/generic/hyphen ${D}usr/share/texmf/tex/generic/hyphen
	texhash "${D}usr/share/texmf"
	sh ./rebuild-formats

	# And tidy up fmtutil's location.
	fmtutil=`kpsewhich --format="web2c files" fmtutil.cnf`
	if [ -L $fmtutil ] ; then
		fmtutil_real=`readlink "${fmtutil}"`
		mkdir -p ${D}`dirname "${fmtutil_real}"`
		mv "${D}${fmtutil}" "${D}${fmtutil_real}"
	fi

	mv ${D}usr/share/texmf/tex/generic/hyphen ${D}usr/share/texmf-site/tex/generic/hyphen

	### Add xetex to the search path for xelatex, if not already done.
	mkdir -p ${D}etc/texmf/web2c
	egrep -q 'TEXINPUTS.xelatex = .;\$TEXMF/tex/{xelatex,latex,generic,}//' /etc/texmf/web2c/texmf.cnf || \
		sed -e 's/TEXINPUTS.xelatex = .;$TEXMF\/tex\/{latex,generic,}\/\//TEXINPUTS.xelatex = .;$TEXMF\/tex\/{xelatex,latex,generic,}\/\//' /etc/texmf/web2c/texmf.cnf > ${D}etc/texmf/web2c/texmf.cnf

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
