# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/evolvotron/evolvotron-0.6.3.ebuild,v 1.1 2013/08/27 20:44:26 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )
inherit python-r1 qt4-r2

DESCRIPTION="Generative art image evolver"
HOMEPAGE="http://sourceforge.net/projects/evolvotron/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	dev-libs/boost
	dev-qt/qtgui:4
"
DEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -e '1s|python|&2|g' text_to_markup.py || die
}

src_configure() {
	eqmake4 main.pro
}

src_compile() {
	./text_to_markup.py -html < USAGE > evolvotron.html
	./text_to_markup.py -qml -s < USAGE > libevolvotron/usage_text.h

	local etsubdir
	for etsubdir in \
		libfunction libevolvotron evolvotron evolvotron_render evolvotron_mutate
		do
		emake sub-${etsubdir}
	done
}

src_install() {
	local bin
	for bin in ${PN}{,_mutate,_render}; do
		dobin ${bin}/${bin}
	done
	doman man/man1/*
	dodoc BUGS NEWS README TODO USAGE
	dohtml *.html
}
