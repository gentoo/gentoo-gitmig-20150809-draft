# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-bibtex/python-bibtex-1.2.3.ebuild,v 1.6 2008/05/19 17:10:41 drac Exp $

inherit distutils

DESCRIPTION="A Python extension to parse BibTeX files"
HOMEPAGE="http://pybliographer.org/"
SRC_URI="mirror://sourceforge/pybliographer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=app-text/recode-3.6-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_test() {
	"${python}" setup.py check || die "tests failed"
}
