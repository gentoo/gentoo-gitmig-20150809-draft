# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Cheetah/Cheetah-0.9.14.ebuild,v 1.9 2003/06/22 12:15:59 liquidx Exp $

VERSION="0.9.14"
S=${WORKDIR}/${P}
DESCRIPTION="Cheetah is a Python-powered template engine and code generator."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/cheetahtemplate/${P}.tar.gz"
HOMEPAGE="http://www.cheetahtemplate.org/"

RDEPEND=">=dev-lang/python-2.2"
DEPEND="${RDEPEND}"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="PSF-2.2"

src_compile() {

	python setup.py build || die

}

src_install() {

    python setup.py install --prefix=${D}/usr || die

    dodoc README docs/devel_guide.txt docs/users_guide.txt docs/users_guide.ps \
          docs/users_guide.pdf docs/devel_guide.pdf docs/devel_guide.ps

    docinto beginners_guide_src
	dodoc docs/beginners_guide_src/*
    
	docinto devel_guide_src
	dodoc docs/devel_guide_src/*

	docinto users_guide_src
    dodoc docs/users_guide_src/*

	#dodoc compresses everything
	#changed to ininto/doins so that html files are not compressed
    insinto usr/share/doc/${PF}/html/devel_guide_html
	doins docs/devel_guide_html/*

	insinto usr/share/doc/${PF}/html/devel_guide_html_multipage
    doins docs/devel_guide_html_multipage/*
	
	insinto usr/share/doc/${PF}/html/users_guide_html
	doins docs/users_guide_html/*
	
	insinto usr/share/doc/${PF}/html/users_guide_html_multipage
	doins docs/users_guide_html_multipage/*
}

