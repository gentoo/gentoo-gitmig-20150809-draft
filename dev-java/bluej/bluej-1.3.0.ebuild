# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bluej/bluej-1.3.0.ebuild,v 1.3 2004/03/02 13:53:34 lanius Exp $

inherit java-pkg

IUSE="doc gnome kde"

MY_P=`echo ${P}|sed -e 's/\.//g'`

DESCRIPTION="BlueJ is an integrated Java environment specifically designed for introductory teaching."
SRC_URI="ftp://ftp.bluej.org/pub/bluej/${MY_P}.jar
	 doc? ( http://www.bluej.org/tutorial/tutorial.pdf
	 http://www.bluej.org/reference/manual.pdf )"
HOMEPAGE="http://www.bluej.org"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND=">=virtual/jdk-1.4*"

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
	mv ${D}/usr/share/bluej/lib/bluej.defs ${D}/etc
	dosym /etc/bluej.defs /usr/share/bluej/lib/bluej.defs

	if [ "`use doc`" ]; then
		dodoc tutorial.pdf manual.pdf
	fi

	if [ "`use gnome`" ]; then
		insinto /usr/share/applications
		doins ${FILESDIR}/bluej.desktop
	fi

	if [ "`use kde`" ]; then
		insinto /usr/share/applnk/Development
		doins ${FILESDIR}/bluej.desktop
	fi
}
