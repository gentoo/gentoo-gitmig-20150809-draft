# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pyrpub/pyrpub-2.1.1.ebuild,v 1.5 2002/10/15 09:59:58 seemant Exp $

NP="pyrite-publisher-${PV}"
S=${WORKDIR}/${NP}
DESCRIPTION="content conversion tool for Palm"
SRC_URI="http://www.pyrite.org/dist/${NP}.tar.gz"
HOMEPAGE="http://www.pyrite.org/publisher/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-lang/python"

src_compile() {
	python setup.py build || die "build failed"
}

src_install () {
	python setup.py install --root="${D}" || die "install failed"
	dodoc ChangeLog NEWS README* doc/*.pdb
	doman doc/*.1
	dohtml -r doc/pyrite-publisher
}
