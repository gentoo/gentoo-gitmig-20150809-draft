# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.05-r1.ebuild,v 1.1 2002/05/24 08:51:44 seemant Exp $

MY_P=linux-${PV/./}
S=${WORKDIR}
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/${MY_P}.tar.gz"
HOMEPAGE="http://www.adobe.com/products/acrobat/"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11"

LICENSE="Adobe"

INSTALLDIR=/opt/Acrobat5

src_compile () {
	
	tar xvf LINUXRDR.TAR
	tar xvf COMMON.TAR

	sed -e "s:REPLACE_ME:${INSTALLDIR}/Reader:" \
		bin/acroread.sh > acroread
}

src_install () {

	dodir ${INSTALLDIR}
	for i in Browsers Reader Resource
	do
		cp -a ${S}/${i} ${D}/${INSTALLDIR}
	done

	exeinto ${INSTALLDIR}
	doexe acroread
	dodoc README LICREAD.TXT MANIFEST
	into /opt/netscape/plugins
	dosym ${INSTALLDIR}/Browsers/intellinux/nppdf.so /opt/netscape/plugins

	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10acroread5

	#mozilla compatibility contributed by m3thos@netcabo.pt(Miguel Sousa Filipe)
	if use mozilla; then
		into /usr/lib/mozilla/plugins
		dosym \
			${INSTALLDIR}/intellinux/nppdf.so \
			/usr/lib/mozilla/plugins/nppdf.so
	fi
}
