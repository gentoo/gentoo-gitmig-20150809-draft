# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/silvercity/silvercity-0.9.7.ebuild,v 1.2 2007/02/13 20:37:02 corsair Exp $

inherit distutils eutils python

DESCRIPTION="A lexical analyser for many languages."
HOMEPAGE="http://silvercity.sourceforge.net/"

MY_P=${P/silvercity/SilverCity}
SRC_URI="mirror://sourceforge/silvercity/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/python-2.3"

src_install() {
	distutils_src_install

	# remove useless documentation
	rm ${D}/usr/share/doc/${P}/PKG-INFO.gz

	# fix permissions
	python_version
	chmod 644 ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/SilverCity/default.css

	# fix CR/LF issue
	find ${D}/usr/bin -iname "*.py" -exec sed -e 's/\r$//' -i \{\} \;

	# fix path
	dosed -i 's|#!/usr/home/sweetapp/bin/python|#!/usr/bin/env python|' \
		/usr/bin/cgi-styler-form.py || die "dosed failed"
}
