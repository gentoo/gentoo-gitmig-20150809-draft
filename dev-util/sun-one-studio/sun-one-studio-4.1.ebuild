# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sun-one-studio/sun-one-studio-4.1.ebuild,v 1.1 2003/04/28 20:36:31 tberman Exp $

DESCRIPTION="Sun ONE Studio Community Edition"
HOMEPAGE="http://wwws.sun.com/software/sundev/jde/features/ce-features.html"
SRC_URI=""
LICENSE="sun-bcla"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.3"
At="ffj_ce.jar"
AtZip="ffj_ce.zip"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} and move it to ${DISTDIR} (Select the unsupported jar archive) Note: This will require registration to download."
	fi
	unzip -q ${DISTDIR}/${At} -d ${S} || die
}

src_install() {
	addwrite "/var/lib/rpm/__db.Name."
	addwrite "/var/lib/rpm/Name"
	java -DjdkHome=`java-config --jdk-home` -DforteHome="${D}/opt/s1studioce/" run -silent
        insinto /usr/share/gnome/apps/Development
        doins ${FILESDIR}/sunone.desktop
}
