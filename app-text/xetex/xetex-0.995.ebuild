# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xetex/xetex-0.995.ebuild,v 1.1 2006/10/28 11:38:16 joslwah Exp $

inherit eutils

DESCRIPTION="Unicode version of tex with other enhancements."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
SRC_URI="http://scripts.sil.org/svn-view/xetex/TAGS/${P}.tar.gz"

LICENSE="XeTeX"
SLOT="0"
KEYWORDS="~ppc64"
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
	# Short term hack instead of patching.  Change to a patch later.
#	sed -e 's/texbindir=`/texbindir=${D}`/' \
#		-e '/cp -pf Work\/texk\/web2c\/xetex ${texbindir}\/xetex/i mkdir -p ${texbindir}' \
#		-e 's/texmflocal=`kpsewhich --var-value TEXMFLOCAL`/texmflocal=${D}usr\/share\/texmf/' \
#		-e 's/.\/rebuild-formats/-x .\/rebuild-formats.gentoo/' install-xetex >install-xetex.gentoo
#	sed -e '/ fmtutil.cnf`/a cp ${fmtutil_cnf} ${D}${fmtutil_cnf}' \
#		-e 's/cat >> ${fmtutil_cnf}/cat >>${D}${fmtutil_cnf}/' \
#		-e 's/texbindir=`/texbindir=${D}`/' \
#		-e '/patch -N -r/i cp `which fmtutil` .' \
#		-e 's/-p0 `which fmtutil`/-p0 fmtutil/' \
#		-e 's/${fmtutil} --enablefmt ${f}/TEXMFLOCAL=${D}usr\/share\/texmf .\/fmtutil --fmtdir ${D}usr\/share\/texmf\/web2c --cnffile ${D}${fmtutil_cnf} --enablefmt ${f}/' \
#		-e 's/${fmtutil} --byfmt ${f}/TEXMFLOCAL=${D}usr\/share\/texmf .\/fmtutil --fmtdir ${D}usr\/share\/texmf\/web2c --cnffile ${D}${fmtutil_cnf} --byfmt ${f}/' \
#		-e 's/texlinks --silent/texlinks --silent --cnffile ${D}${fmtutil_cnf} ${D}usr\/share\/texmf\/web2c/' rebuild-formats >rebuild-formats.gentoo
	sh -x install-xetex || die

	# Need to softlink xelatex to xetex.
	cd ${D}/usr/bin
	ln -s xetex xelatex

	# Do we need to worry about /usr/share/texmf being explicit?  
	# What happens if this doesn't match the tex install place?
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
