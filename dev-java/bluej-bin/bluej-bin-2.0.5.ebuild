# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bluej-bin/bluej-bin-2.0.5.ebuild,v 1.3 2007/07/11 19:58:38 mr_bones_ Exp $

inherit java-pkg

IUSE="doc"

MY_P=${P//.}
MY_P=${MY_P/-bin}
DESCRIPTION="BlueJ is an integrated Java environment specifically designed for introductory teaching."
SRC_URI="http://www.bluej.org/download/files/${MY_P}.jar
	 doc? ( http://www.bluej.org/tutorial/tutorial.pdf
	 http://www.bluej.org/reference/BlueJ-reference.pdf
	 http://www.bluej.org/tutorial/testing-tutorial.pdf )"
HOMEPAGE="http://www.bluej.org"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4
	dev-java/antlr
	dev-java/junit"

src_unpack()
{
	unzip -qq ${DISTDIR}/${MY_P}.jar -d ${S}
	if use doc; then
		cp ${DISTDIR}/manual.pdf ${S}
		cp ${DISTDIR}/*tutorial.pdf ${S}
	fi
	unzip -qq ${S}/Installer.class -d ${S}

	cd ${S}/lib
	rm junit.jar antlr.jar
}

src_compile() { :; }

src_install()
{
	dodir /usr/share/${PN}
	cp -R lib ${D}/usr/share/${PN}/
	java-pkg_dojar lib/*.jar
	cp -R examples ${D}/usr/share/${PN}/

	newbin ${FILESDIR}/${PN}-2.0.4 bluej

	dodir /etc
	mv ${D}/usr/share/${PN}/lib/bluej.defs ${D}/etc
	dosym /etc/bluej.defs /usr/share/${PN}/lib/bluej.defs

	# TODO: replace this with an better solution
	# works for the moment, though
	ln -s `java-config -p antlr` ${D}/usr/share/${PN}/lib
	ln -s `java-config -p junit` ${D}/usr/share/${PN}/lib

	if use doc; then
		dodoc *.pdf
	fi

	insinto /usr/share/applications
	doins ${FILESDIR}/bluej.desktop
}
