# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/camato/camato-0.6.2.ebuild,v 1.1 2004/09/10 19:52:37 rizzo Exp $

MY_PV=${PV//./_}

DESCRIPTION="Camato is a map editor for the game gnocatan."
HOMEPAGE="http://yusei.ragondux.com/loisirs_jdp_catane_camato-en.html"
SRC_URI="http://yusei.ragondux.com/files/gnocatan/${PN}-${MY_PV}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-ruby/ruby-gtk2"
#RDEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	# TODO - I need to handle the fr.rb translation eventually

	exeinto /usr/bin
	doexe camato.rb

	# maybe just do newexe and not have the .rb file?
	dosym /usr/bin/camato.rb /usr/bin/camato

	dodoc README ChangeLog
}
