# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop-bin/fop-bin-0.20.4.ebuild,v 1.3 2003/03/01 04:51:11 vapier Exp $

P=${P/-bin/}
PN=${PN/-bin/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="http://xml.apache.org/dist/fop/${P}-bin.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=virtual/jdk-1.4"

src_install() {
	sed '2itest "$FOP_HOME" || FOP_HOME=/usr/share/fop/' fop.sh > fop
	exeinto /usr/bin
	doexe fop

	dojar lib/*.jar build/*.jar
	dodoc LICENSE README CHANGES ReleaseNotes.html STATUS
	dodoc lib/*.txt docs/*.pdf conf/*
	dohtml -r docs/html-docs/*
}
