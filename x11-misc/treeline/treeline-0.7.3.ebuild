# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/treeline/treeline-0.7.3.ebuild,v 1.1 2004/05/26 17:36:33 taviso Exp $

inherit eutils

DESCRIPTION="TreeLine is a structured information storage program."
HOMEPAGE="http://www.bellz.org/treeline/"

SRC_URI="http://www.bellz.org/treeline/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="spell"

DEPEND="spell? ( || ( app-text/aspell app-text/ispell ) )
	|| ( dev-python/pyxml dev-libs/expat )
	dev-lang/python dev-python/PyQt
	>=x11-libs/qt-3.3.0-r1"

S=${WORKDIR}/TreeLine

src_compile() {

	# gah. :(
	sed -i "s#f = open(path, 'r')#return#g" ${S}/install.py || die
	sed -i "s#\(helpFilePath =\) None#\1 '/usr/share/doc'#g" ${S}/source/*.py || die
	sed -i "s#\(dataFilePath =\) None#\1 '/usr/lib/treeline'#g" ${S}/source/*.py || die
	sed -i "s#\(copyDir('icons',\) iconDir)#\1 \'${D}/usr/share/icons\')#g" ${S}/install.py || die

	# optional {a,i}spell suport
	if ! use spell; then
		sed -i 's/\(testSpell =\) 1/\1 0/g' ${S}/install.py || {
			ewarn "failed to disable check for spell support"
		}
	fi

	printf '#!/bin/sh\n\nexec %s %s/%s.py $*' \
		python /usr/lib/treeline treeline > ${T}/treeline
}

src_install() {
	python ${S}/install.py -p ${D}/usr || die "installation script failed!"

	insinto /usr/lib/treeline
	doins ${S}/doc/README.html

	dobin ${T}/treeline

	# FIXME: dohtml the html file.
	mv ${D}/usr/share/doc/${PN} ${D}/usr/share/doc/${P}
	prepalldocs
}
