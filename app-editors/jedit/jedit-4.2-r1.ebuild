# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.2-r1.ebuild,v 1.2 2005/03/01 21:11:37 luckyduck Exp $

inherit java-pkg eutils

MY_PV="${PV//.}"
MY_PV="${MY_PV//_}"

DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/jedit/jedit${MY_PV}source.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT="0"
IUSE="doc jikes"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	doc? (
		>=app-text/docbook-xml-dtd-4.3
		>=app-text/docbook-xsl-stylesheets-1.65.1
		dev-libs/libxslt
	)
	>=dev-java/ant-1.5.4
	jikes? ( >=dev-java/jikes-1.17 )"

S="${WORKDIR}/jEdit"

src_unpack() {
	unpack ${A}
	cd ${S}

	local xsl=$(best_version docbook-xsl-stylesheets);
	xml=${xml/docbook-};
	xml=${xml/*\/}

	local xml=$(best_version docbook-xml-dtd)
	xsl=${xsl/docbook-}
	xsl=${xsl/*\/}

	if use doc; then
		echo "build.directory=." > build.properties
		echo "docbook.dtd.catalog=/usr/share/sgml/docbook/${xml}/docbook.cat" \
			 >> build.properties
		echo "docbook.xsl=/usr/share/sgml/docbook/${xsl}" \
			 >> build.properties
	fi
}
src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc docs-html"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install () {
	dodir /usr/share/jedit
	dodir /usr/bin

	insinto /usr/share/jedit
	doins -r jedit.jar jars doc modes properties startup
	keepdir /usr/share/jedit/jars

	echo "#!/bin/bash" > ${PN}
	echo "\$(java-config -J) -jar /usr/share/jedit/jedit.jar \$@" >> ${PN}
	dobin ${PN}

	insinto /usr/share/icons/hicolor/128x128/apps
	newins ${S}/doc/jedit.png jedit.pngs

	make_desktop_entry jedit "jEdit" jedit
}

pkg_postinst() {
	einfo "The system directory for jEdit plugins is"
	einfo "/usr/share/jedit/jars"
}

pkg_postrm() {
	einfo "jEdit plugins installed into /usr/share/jedit/jars"
	einfo "(after installation of jEdit itself) haven't been"
	einfo "removed. To get rid of jEdit completely, you may"
	einfo "want to run"
	einfo ""
	einfo "\trm -r /usr/share/jedit"
}
