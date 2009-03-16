# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/treeline/treeline-1.2.2.ebuild,v 1.1 2009/03/16 11:58:54 pva Exp $

EAPI=2
inherit python

DESCRIPTION="TreeLine is a structured information storage program."
HOMEPAGE="http://treeline.bellz.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="spell"

LANGS="de fr"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI} linguas_${lang}? ( mirror://berlios/${PN}/${PN}-i18n-${PV}a.tar.gz )"
done

DEPEND="spell? ( || ( app-text/aspell app-text/ispell ) )
	>=dev-lang/python-2.3[xml]
	>=dev-python/PyQt4-4.1"

S=${WORKDIR}/TreeLine

src_unpack() {
	unpack ${P}.tar.gz
	for lang in ${LANGS}; do
		if use linguas_${lang}; then
			tar xozf ${DISTDIR}/${PN}-i18n-${PV}a.tar.gz \
				TreeLine/doc/{readme_${lang}.trl,README_${lang}.html} \
				TreeLine/translations/{treeline_${lang}.{qm,ts},qt_${lang}.{qm,ts}} || die
		fi
	done
}

src_install() {
	python install.py -x -p /usr/ -d /usr/share/${PF} -b "${D}"
}

