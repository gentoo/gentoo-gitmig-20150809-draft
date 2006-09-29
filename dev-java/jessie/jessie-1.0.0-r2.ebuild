# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jessie/jessie-1.0.0-r2.ebuild,v 1.1 2006/09/29 22:44:59 caster Exp $

inherit java-pkg-2 eutils

DESCRIPTION="Free JSSE implementation"
HOMEPAGE="http://www.nongnu.org/jessie"
SRC_URI="http://syzygy.metastatic.org/jessie/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="dev-java/gnu-crypto"
# chokes on the bundled ssl API in 1.5+ which gnu-crypto prolly can't override
# (endorsed fun?)
DEPEND="=virtual/jdk-1.4*
	${RDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# TODO file upstream
	# without this, make apidoc fails (a URL has changed)
	epatch "${FILESDIR}/${P}-javadoc.patch"
}

src_compile() {

	export CLASSPATH="${CLASSPATH}:$(java-pkg_getjars gnu-crypto):"

	local target="$(java-pkg_get-target)"

	econf --with-java-target=${target} --disable-awt || die "econf failed"
	emake || die "emake failed"

	if use doc; then
		emake apidoc || "emake apidoc failed"
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
