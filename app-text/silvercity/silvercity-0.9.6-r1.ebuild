# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/silvercity/silvercity-0.9.6-r1.ebuild,v 1.2 2006/02/19 22:57:34 kloeri Exp $

inherit distutils eutils python

DESCRIPTION="A lexical analyser for many languages."
HOMEPAGE="http://silvercity.sourceforge.net/"

MY_P=${P/silvercity/SilverCity}
SRC_URI="mirror://sourceforge/silvercity/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-api-fix.patch
}

src_install() {
	distutils_src_install

	# fix permissions
	python_version
	chmod 644 ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/SilverCity/default.css

	# fix CR/LF issue
	find ${D}/usr/bin -iname "*.py" -exec sed -e 's/\r$//' -i \{\} \;

	# fix path
	dosed -i 's|#!/usr/home/sweetapp/bin/python|#!/usr/bin/env python|' \
		/usr/bin/cgi-styler-form.py || die "dosed failed"
}
