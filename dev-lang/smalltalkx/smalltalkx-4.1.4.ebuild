# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smalltalkx/smalltalkx-4.1.4.ebuild,v 1.2 2003/02/13 10:29:19 vapier Exp $

DESCRIPTION="The non-commercial version of a complete implementation of the Smalltalk programming language and development environment"
HOMEPAGE="http://www.exept.de/exept_99/english/welcomeFrame_smalltalk.html"
SRC_URI="mirror://gentoo/smalltalkx-common-414.tar.gz
	mirror://gentoo/smalltalkx-linux-414.tar.gz"
DEPEND="virtual/glibc virtual/x11"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
S=${WORKDIR}/stx
IUSE=""

src_install () {
	dodir /opt
	./INSTALL.sh -q -top ${D}/opt

	dosed ${D}/opt/smalltalk/${PV}/bin/smalltalk

	cd ${D}/opt/smalltalk/${PV}/
	for i in `find . -type l` ; do
		foo=`ls -l ${i} | sed "s/.*-> //" | sed "s_${D}__"`
		rm $i
		ln -sf ${foo} $i
	done

	dodir /usr/bin
	dosym /opt/smalltalk/${PV}/bin/smalltalk /usr/bin/smalltalk 
}
