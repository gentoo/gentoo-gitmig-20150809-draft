# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-bibtex/python-bibtex-1.2.1.ebuild,v 1.2 2004/11/13 15:52:29 hansmi Exp $

inherit distutils

DESCRIPTION="A Python extension to parse BibTeX files"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-libs/glib-2
	>=app-text/recode-3.6-r1"
