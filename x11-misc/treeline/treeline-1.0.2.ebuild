# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/treeline/treeline-1.0.2.ebuild,v 1.1 2007/06/07 08:57:21 nelchael Exp $

inherit python

DESCRIPTION="TreeLine is a structured information storage program."
HOMEPAGE="http://www.bellz.org/treeline"
SRC_URI="http://www.bellz.org/${PN}/${P}.tar.gz
	http://www.bellz.org/${PN}/${PN}-i18n-${PV}a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="spell"

DEPEND="spell? ( || ( app-text/aspell app-text/ispell ) )
	|| ( dev-python/pyxml dev-libs/expat )
	virtual/python dev-python/PyQt
	=x11-libs/qt-3*"

S="${WORKDIR}"/TreeLine

# Before you go editing below read bugs 177652 and 177645
# or you'll end up breaking it.

src_compile() {
	printf '#!/bin/sh\n\nexec python %s/treeline.py $*\n' \
		/usr/share/treeline > ${S}/treeline
	sed -i -e "s#\(helpFilePath = \)None#\1'/usr/share/treeline'#g" \
		-e "s#\(iconPath = \)None#\1'/usr/share/treeline/icons'#g" \
			${S}/source/treeline.py || die
	sed -i -e 's,translations,/usr/share/treeline/translations,' \
		${S}/source/treeline.py || die
}

src_install() {
	insinto /usr/share/${PN}
	doins source/*.py doc/*.html doc/*.png doc/*.trl

	insinto /usr/share/${PN}/icons
	doins icons/*.png

	insinto /usr/share/${PN}/translations
	doins translations/*.qm

	dobin ${PN}
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
