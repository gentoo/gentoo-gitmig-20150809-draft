# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Cheetah/Cheetah-0.9.15.ebuild,v 1.2 2003/05/22 17:36:25 agenkin Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
LICENSE="PSF-2.2"

KEYWORDS="x86 ~sparc ~alpha"
SLOT="0"

RDEPEND=">=dev-lang/python-2.2"
DEPEND="${RDEPEND}"

SRC_URI="mirror://sourceforge/cheetahtemplate/${P}.tar.gz"


src_install() {
	distutils_src_install 
	
	# What's the best way to deal with the examples?
	insinto /usr/share/doc/${PF}/examples
	doins examples/webware_examples/cheetahSite/*
}
