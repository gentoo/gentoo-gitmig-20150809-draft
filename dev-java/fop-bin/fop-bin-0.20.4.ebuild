# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop-bin/fop-bin-0.20.4.ebuild,v 1.9 2004/07/14 01:53:24 agriffis Exp $

MY_P=${P/-bin/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="http://xml.apache.org/dist/fop/${MY_P}-bin.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
		!dev-java/fop"

S=${WORKDIR}/${MY_P}

src_install() {
	sed '2itest "$FOP_HOME" || FOP_HOME=/usr/share/fop/' fop.sh > fop
	exeinto /usr/bin
	doexe fop

	env PN=${PN/-bin/} dojar lib/*.jar build/*.jar
	dodoc LICENSE README CHANGES ReleaseNotes.html STATUS
	dodoc lib/*.txt docs/*.pdf conf/*
	dohtml -r docs/html-docs/*
}
