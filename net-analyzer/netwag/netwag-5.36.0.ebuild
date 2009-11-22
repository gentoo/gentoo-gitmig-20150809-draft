# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwag/netwag-5.36.0.ebuild,v 1.1 2009/11/22 23:33:27 jer Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

EAPI="2"

DESCRIPTION="Tcl/tk interface to netwox (Toolbox of 222 utilities for testing Ethernet/IP networks)"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwag/"
BASEURI="http://www.laurentconstantin.com/common/netw/${PN}/download/"
SRC_URI="
	${BASEURI}v${PV/.*}/${P}-src.tgz
	doc? ( ${BASEURI}v${PV/.*}/${P}-doc_html.tgz )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

DEPEND="~net-analyzer/netwox-${PV}
	>=dev-lang/tk-8
	|| ( x11-terms/xterm
		x11-terms/eterm
		x11-terms/rxvt
		x11-terms/gnome-terminal
		kde-base/konsole )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src/src"

src_prepare() {
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/usr/local:/usr:" \
		config.dat
}

src_configure() {
	sh genemake || die "problem creating Makefile"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ../README.TXT
	if use doc;
	then
		mv "${WORKDIR}"/${P}-doc_html "${D}"/usr/share/doc/${PF}/html
	else
		dodoc "${S}"/../doc/{changelog.txt,credits.txt} \
			"${S}"/../doc/{problemreport.txt,problemusage.txt,todo.txt}
	fi
}
