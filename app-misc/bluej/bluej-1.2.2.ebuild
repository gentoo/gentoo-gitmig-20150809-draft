# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bluej/bluej-1.2.2.ebuild,v 1.1 2003/05/25 00:28:38 tberman Exp $

inherit java-pkg

IUSE="doc"

MY_P="bluej-122"

DESCRIPTION="BlueJ is an integrated Java environment specifically designed for introductory teaching."
SRC_URI="ftp://ftp.bluej.org/pub/bluej/${MY_P}.jar 
	 doc? ( http://www.bluej.org/tutorial/tutorial.pdf 
	 http://www.bluej.org/reference/manual.pdf )"
HOMEPAGE="http://www.bluej.org"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-java/sun-jdk-1.4*"

src_unpack()
{
	unzip ${DISTDIR}/${MY_P}.jar -d ${S}
	if [ "`use doc`" ]; then
		cp ${DISTDIR}/manual.pdf ${S}
		cp ${DISTDIR}/tutorial.pdf ${S}
	fi
	unzip ${S}/Installer.class -d ${S}
}

src_compile() {
	einfo "No compilation required"
}

src_install()
{
	dodir /usr/share/bluej/
	cp -R lib ${D}/usr/share/bluej/
	java-pkg_dojar lib/*.jar
	java-pkg_dojar lib/*.zip
	cp -R examples ${D}/usr/share/bluej/

	dobin ${FILESDIR}/bluej

	dodir /etc
	dosym /usr/share/bluej/lib/bluej.defs /etc/bluej.defs
	
	if [ "`use doc`" ]; then
		dodoc tutorial.pdf manual.pdf
	fi
}
