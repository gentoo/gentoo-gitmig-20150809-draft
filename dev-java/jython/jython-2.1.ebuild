# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jython/jython-2.1.ebuild,v 1.1 2003/04/29 22:15:33 tberman Exp $

DESCRIPTION="Java Python implementation"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://www.jython.org"
MY_PV="21"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.class"
LICENSE="JPython"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=virtual/jdk-1.2"

src_unpack() {

	unzip ${DISTDIR}/${PN}-${MY_PV}.class -d ${S}/ 

}

src_install() {
	dojar jython.jar
	dodoc README.txt NEWS ACKNOWLEDGMENTS LICENSE.txt
	dohtml -A .css .jpg .gif -r Doc
}
