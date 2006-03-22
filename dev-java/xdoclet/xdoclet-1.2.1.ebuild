# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.1.ebuild,v 1.9 2006/03/22 06:58:58 wormo Exp $

inherit java-pkg

XJAVADOC_PV=1.0.3

DESCRIPTION="XDoclet is an extended Javadoc Doclet engine."
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz
	mirror://gentoo/xjavadoc-${XJAVADOC_PV}-src.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="jikes"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	jikes? ( dev-java/jikes )
	>=dev-java/ant-1.5"

#	 cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/xdoclet \
#		 co -r XJAVADOC_1_0_3 xjavadoc
#	 tar cjf xjavadoc-1.0.3-src.tar.bz2 xjavadoc

src_unpack() {
	unpack ${A}
	if use jikes; then
		sed -e 's/compiler = modern/compiler = jikes/' -i build.properties
	fi
}

src_compile() {
	# Maven is just plain madness...
	#
	# You can grab the documentation on-line at http://xdoclets.sf.net
	# or use the XDoclet Maven plugin installed with dev-java/maven.
	#
	# You may also consider placing an ebuild "enchancement" at
	# http://bugs.gentoo.org/ which allows Maven to work without
	# downloading sundry JARs from the Internet.

	ANT_OPT=-Xmx128m ant \
		-Domit.maven=true \
		-Domit.docs=true \
		-Dmaven.command=true || die
}

src_install() {
	java-pkg_dojar target/lib/*.jar
	cp -r target/docs target/generated-xdocs samples ${D}/usr/share/doc/${P}
}
