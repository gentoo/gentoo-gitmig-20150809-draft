# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lupy/lupy-0.1.5.5.1.ebuild,v 1.1 2004/02/17 14:37:48 lordvan Exp $

inherit distutils

MY_PN="Lupy"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Lupy is a is a full-text indexer and search engine written in Python."
HOMEPAGE="http://www.divmod.org/Lupy/index.html"
SRC_URI="mirror://sourceforge/lupy/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

S=${WORKDIR}/${MY_P}

