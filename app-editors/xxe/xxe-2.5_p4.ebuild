# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xxe/xxe-2.5_p4.ebuild,v 1.2 2004/03/26 10:30:32 dholm Exp $

MY_PV="${PV/./}"
MY_PV="${MY_PV/_/}"
S="${WORKDIR}/${PN}-std-${MY_PV}"
DESCRIPTION="Java-based XML Editor"
SRC_URI="http://www.xmlmind.net/xmleditor/_download/${PN}-std-${MY_PV}.tar.gz"
HOMEPAGE="http://www.xmlmind.com/xmleditor/index.html"
IUSE=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

RESTRICT="nostrip nomirror"
RDEPEND=">=virtual/jdk-1.4.1"
DEPEND=""
INSTALLDIR=/opt/${PN}

src_install() {
	dodir ${INSTALLDIR}
	cp -a ${S}/* ${D}/${INSTALLDIR}

	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10xxe
}
