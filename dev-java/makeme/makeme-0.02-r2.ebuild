# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/makeme/makeme-0.02-r2.ebuild,v 1.14 2006/10/05 18:06:27 gustavoz Exp $

inherit java-pkg eutils

DESCRIPTION="Make utility written in Java"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://makeme.sf.net"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/antlr-2.7.1-r1"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

# jikes support disabled for now.
# refer to bug #100020 and bug #89711

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	#if ! use jikes; then
		sed -e 's!jikes!javac!' -i Makefile
	#fi
	make build || die "Compile failed"
	make install || die "Create Jar failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	newbin ${FILESDIR}/${PN}.sh ${PN}
	doman doc/${PN}.1
}
