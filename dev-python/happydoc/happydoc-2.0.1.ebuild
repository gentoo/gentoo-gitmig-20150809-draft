# HappyDoc is a tool for extracting documentation from Python source code.
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-2.0.1.ebuild,v 1.1 2002/05/15 02:53:21 jnelson Exp $

# HappyDoc version numbering is not very compatible with portage -- kludgeing
S=${WORKDIR}/HappyDoc-r2_0_1/

DESCRIPTION="HappyDoc is a tool for extracting documentation from Python sourcecode."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/happydoc/HappyDoc_r2_0_1.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

DEPEND="virtual/python"
SLOT="0"
LICENSE=""

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc CHANGES.txt README.txt test_happydoc.py
}
