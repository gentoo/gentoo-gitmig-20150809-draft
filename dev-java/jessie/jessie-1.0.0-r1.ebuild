# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jessie/jessie-1.0.0-r1.ebuild,v 1.1 2006/01/06 18:15:03 betelgeuse Exp $

inherit java-pkg eutils

DESCRIPTION="Free JSSE implementation"
HOMEPAGE="http://www.nongnu.org/jessie"
SRC_URI="http://syzygy.metastatic.org/jessie/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc ssl"
#IUSE="doc jikes ssl"

RDEPEND=">=virtual/jre-1.4
	ssl? ( dev-java/gnu-crypto )"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

# Jikes needs to learn how to get system libraries so it can play nice.
# Until then, we're going to disable jikes support
#	jikes? ( >=dev-java/jikes-1.19 )

src_unpack() {
	unpack ${A}
	cd ${S}
	# TODO file upstream
	# without this, make apidoc fails (a URL has changed)
	epatch "${FILESDIR}/${P}-javadoc.patch"
}

src_compile() {

	local MY_CLASSPATH="${CLASSPATH}"
	use ssl && MY_CLASSPATH="${MY_CLASSPATH}:$(java-pkg_getjars gnu-crypto)"

	CLASSPATH="${MY_CLASSPATH}:" econf --with-java-target=1.4 --disable-awt || die
	emake || die

	if use doc; then
		 emake apidoc
		mv apidoc api || die "Renaming apidoc failed."
	fi
}

src_install() {
	einstall || die
	rm ${D}/usr/share/*.jar

	java-pkg_dojar lib/*.jar

	use doc && java-pkg_dohtml -r api

	dodoc AUTHORS FAQ INSTALL NEWS README THANKS TODO
}
