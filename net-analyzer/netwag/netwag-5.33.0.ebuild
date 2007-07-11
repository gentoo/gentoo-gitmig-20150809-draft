# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwag/netwag-5.33.0.ebuild,v 1.5 2007/07/11 23:49:24 mr_bones_ Exp $

# NOTE: netwib, netwox and netwag go together, bump all or bump none

DESCRIPTION="Tcl/tk interface to netwox (Toolbox of 217 utilities for testing Ethernet/IP networks)"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwag/"
SRC_URI="http://www.laurentconstantin.com/common/netw/${PN}/download/v${PV/.*}/${P}-src.tgz
	doc? (
	http://www.laurentconstantin.com/common/netw/netwag/download/v${PV/.*}/${P}-doc_html.tgz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc"

DEPEND="~net-analyzer/netwox-${PV}
	>=dev-lang/tk-8
	|| ( x11-terms/xterm
		x11-terms/eterm
		x11-terms/rxvt
		x11-terms/gnome-terminal
		kde-base/konsole
		kde-base/kdebase )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	sed -i \
		-e 's:/man$:/share/man:g' \
		-e "s:/usr/local:/usr:" \
		config.dat

	./genemake || die "problem creating Makefile"
}

src_compile() {
	cd src
	emake || die "compile problem"
}

src_install() {
	dodoc README.TXT
	if use doc;
	then
		mv "${WORKDIR}"/${P}-doc_html "${D}"/usr/share/doc/${PF}/html
	else
		dodoc doc/{changelog.txt,credits.txt} \
			doc/{problemreport.txt,problemusage.txt,todo.txt}
	fi
	cd src
	make install DESTDIR="${D}" || die
}
