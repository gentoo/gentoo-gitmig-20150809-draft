# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfltk/pyfltk-1.1.2.ebuild,v 1.1 2007/12/07 11:24:11 bicatali Exp $

inherit distutils

MY_P=pyFltk-${PV}

DESCRIPTION="Python interface to Fltk library"
HOMEPAGE="http://pyfltk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	doc? ( http://junk.mikeasoft.com/pyfltkmanual.pdf )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-lang/swig-1.3.29
	>=x11-libs/fltk-1.1.7"

RDEPEND=">=x11-libs/fltk-1.1.7"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_install() {
	distutils_src_install --install-data /usr/share/doc/${PF}
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/pyfltkmanual.pdf
	fi
}
