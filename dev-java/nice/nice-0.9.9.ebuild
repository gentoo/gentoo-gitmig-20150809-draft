# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nice/nice-0.9.9.ebuild,v 1.1 2004/11/14 13:22:19 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="A programming language based on, and extending from, Java."

HOMEPAGE="http://nice.sourceforge.net"
SRC_URI="mirror://sourceforge/nice/Nice-${PV}-source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=virtual/jdk-1.3"
DEPEND=">=virtual/jre-1.3
		sys-apps/groff
		>=dev-java/javacc-3.2"
NICE="nice-${PV}.orig"
S="${WORKDIR}/${NICE}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch

	cd ${S}/external
	java-pkg_jar-from javacc
}

src_compile() {
	make || die "failed to compile"
	mkdir man
	./bin/nicec --man > man/nicec.1
	./bin/niceunit --man > man/niceunit.1
	groff -mandoc -Thtml man/nicec.1 > man/nicec.html
}

src_test() { :; }

src_install() {
	dobin bin/nicec || die "nicec is missing"
	dosym nicec /usr/bin/niceunit
	java-pkg_dojar share/java/nice.jar
	doman man/*.1
	dohtml man/nicec.html
}
