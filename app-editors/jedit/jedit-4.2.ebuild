# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.2.ebuild,v 1.8 2004/12/04 17:44:59 slarti Exp $

inherit java-utils

MY_PV="${PV//.}"
MY_PV="${MY_PV//_}"

DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/jedit/jedit${MY_PV}source.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc amd64"
SLOT="0"
IUSE="jikes doc"

RDEPEND=">=virtual/jdk-1.4"
DEPEND="${RDEPEND}
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
		echo "docbook.dtd.catalog=/usr/share/sgml/docbook/${xml}/docbook.cat" >> build.properties
		echo "docbook.xsl=/usr/share/sgml/docbook/${xsl}" >> build.properties
	fi
}
src_compile() {
	local antflags="dist"

	if use jikes ; then
		einfo "Please ignore the following compiler warnings."
		einfo "Jikes is just too pedantic..."
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi

	use doc && antflags="${antflags} javadoc docs-html"

	ant ${antflags} || die "compile problem"
}

src_install () {
	dodir /usr/share/jedit
	dodir /usr/bin

	cp -R jedit.jar jars doc macros modes properties startup ${D}/usr/share/jedit
	cd ${D}/usr/share/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		jedit.jar jars doc macros modes properties startup

	cat >${D}/usr/share/jedit/jedit.sh <<-EOF
		#!/bin/bash

		java -jar /usr/share/jedit/jedit.jar \$@
	EOF
	chmod 755 ${D}/usr/share/jedit/jedit.sh

	ln -s ../share/jedit/jedit.sh ${D}/usr/bin/jedit

	keepdir /usr/share/jedit/jars
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
