# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mosml/mosml-2.01-r1.ebuild,v 1.3 2009/07/23 23:14:32 vostorga Exp $

inherit eutils

S="${WORKDIR}/${PN}/src"
DESCRIPTION="Moscow ML - a lightweight implementation of Standard ML (SML)"
SRC_URI="http://www.itu.dk/people/sestoft/mosml/mos201src.tar.gz"
HOMEPAGE="http://www.itu.dk/people/sestoft/mosml.html"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-malloc.patch" #154859

	#Fixing pre-stripped files
	sed -i -e "/STRIP/d" mosmlyac/Makefile || die "sed Makefile failed"
	sed -i -e "/STRIP/d" runtime/Makefile || die "sed Makefile failed"
}

src_compile() {
	emake CC=$(tc-getCC) MOSMLHOME=/opt/mosml world || die
}

src_install () {

	make MOSMLHOME="${D}"/opt/mosml install || die
	rm "${D}"/opt/mosml/lib/camlrunm # This is a bad symlink
	echo "#!/opt/mosml/bin/camlrunm" > "${D}"/opt/mosml/lib/header

	dodoc  ../README
	into   /usr/bin
	dosym  /opt/mosml/bin/mosml     /usr/bin/mosml
	dosym  /opt/mosml/bin/mosmlc    /usr/bin/mosmlc
	dosym  /opt/mosml/bin/mosmllex  /usr/bin/mosmllex
	dosym  /opt/mosml/bin/mosmlyac  /usr/bin/mosmlyac
	dosym  /opt/mosml/bin/camlrunm  /usr/bin/camlrunm
	dosym  /opt/mosml/bin/camlrunm  /opt/mosml/lib/camlrunm

}
