# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/treeline/treeline-1.2.3.ebuild,v 1.3 2009/12/20 19:56:48 hwoarang Exp $

EAPI=2
NEED_PYTHON="2.4"
PYTHON_USE_WITH="xml"

inherit eutils python

DESCRIPTION="TreeLine is a structured information storage program."
HOMEPAGE="http://treeline.bellz.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="spell"

LANGS="de fr"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI} linguas_${lang}? ( mirror://berlios/${PN}/${PN}-i18n-${PV}a.tar.gz )"
done

DEPEND="spell? ( || ( app-text/aspell app-text/ispell ) )
	dev-python/PyQt4[X]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/TreeLine"

src_unpack() {
	unpack ${P}.tar.gz
	for lang in ${LANGS}; do
		if use linguas_${lang}; then
			tar xozf "${DISTDIR}"/${PN}-i18n-${PV}a.tar.gz \
				TreeLine/doc/{readme_${lang}.trl,README_${lang}.html} \
				TreeLine/translations/{treeline_${lang}.{qm,ts},qt_${lang}.{qm,ts}} || die
		fi
	done
}

src_prepare() {
	# let's leave compiling to python_mod_optimize
	epatch "${FILESDIR}"/${P}-nocompile.patch

	# install into proper python site-packages dir
	sed -i "s;prefixDir, 'lib;'$(python_get_sitedir);" install.py || die 'sed failed'

	rm doc/LICENSE
}

src_install() {
	"${python}" install.py -x -p /usr/ -d /usr/share/doc/${PF} -b "${D}"
}

pkg_postinst() {
	python_mod_optimize "$(python_get_sitedir)/${PN}"
}

pkg_postrm() {
	python_mod_cleanup
}
