# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bluej-bin/bluej-bin-1.3.5.ebuild,v 1.1 2004/07/30 19:13:31 axxo Exp $

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
KEYWORDS="x86 ~sparc"

DEPEND=">=virtual/jdk-1.4*"

src_unpack()
{
	unzip ${DISTDIR}/${MY_P}.jar -d ${S}
	if use doc; then
		cp ${DISTDIR}/manual.pdf ${S}
		cp ${DISTDIR}/tutorial.pdf ${S}
	fi
	unzip ${S}/Installer.class -d ${S}
}

src_compile() { :; }

src_install()
{
	dodir /usr/share/bluej/
	cp -R lib ${D}/usr/share/bluej/
	java-pkg_dojar lib/*.jar
	java-pkg_dojar lib/*.zip
	cp -R examples ${D}/usr/share/bluej/

	dobin ${FILESDIR}/bluej

	dodir /etc
	mv ${D}/usr/share/bluej/lib/bluej.defs ${D}/etc
	dosym /etc/bluej.defs /usr/share/bluej/lib/bluej.defs

	if use doc; then
		dodoc tutorial.pdf BlueJ-referenc.pdf testing-tutorial.pdf
	fi

	insinto /usr/share/applications
	doins ${FILESDIR}/bluej.desktop
}
