# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nice/nice-0.9.9.ebuild,v 1.2 2004/12/07 14:51:47 axxo Exp $

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
	cp bin/nicec bin/nicec-gentoo
	sed -i 's/NICEC_JAR=.*/NICEC_JAR=`java-config -p nice`/' bin/nicec-gentoo || die "sed failed"

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
	newbin bin/nicec-gentoo nicec || die "nicec is missing"
	dosym nicec /usr/bin/niceunit
	dosym nicedoc /usr/bin/niceunit
	java-pkg_dojar share/java/nice.jar
	doman man/*.1
	dohtml man/nicec.html
}
