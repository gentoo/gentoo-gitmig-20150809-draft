# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smalltalkx/smalltalkx-4.1.4.ebuild,v 1.3 2003/06/07 08:02:25 seemant Exp $

IUSE=""

MY_PV=${PV//./}
S=${WORKDIR}/stx
DESCRIPTION="The non-commercial version of a complete implementation of the Smalltalk programming language and development environment"
HOMEPAGE="http://www.exept.de/exept_99/english/welcomeFrame_smalltalk.html"
SRC_URI="mirror://gentoo/${PN}-common-${MY_PV}.tar.gz
	mirror://gentoo/${PN}-linux-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND="virtual/glibc virtual/x11"

src_install () {
	dodir /opt
	./INSTALL.sh -q -top ${D}/opt

	dosed /opt/smalltalk/${PV}/bin/smalltalk

	cd ${D}/opt/smalltalk/${PV}/
	for i in `find . -type l` ; do
		foo=`ls -l ${i} | sed "s/.*-> //" | sed "s_${D}__"`
		rm $i
		ln -sf ${foo} $i
	done

	dodir /usr/bin
	dosym /opt/smalltalk/${PV}/bin/smalltalk /usr/bin/smalltalk 

	# create a path entry in /etc/env.d
	echo "PATH=/opt/smalltalk/${PV}/bin" >> ${WORKDIR}/50smalltalkx
	insinto /etc/env.d
	doins ${WORKDIR}/50smalltalkx
	
}
