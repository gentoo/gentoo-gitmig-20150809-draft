# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.06.ebuild,v 1.2 2002/08/06 14:47:13 gerk Exp $

MY_P=linux-${PV/./}
S=${WORKDIR}
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/${MY_P}.tar.gz"
HOMEPAGE="http://www.adobe.com/products/acrobat/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="x86 -ppc"

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
		chown -R root.root ${i}
		cp -a ${i} ${D}${INSTALLDIR}
	done
	
	exeinto ${INSTALLDIR}
	doexe acroread
	dodoc README LICREAD.TXT
	dodir /opt/netscape/plugins
	dosym ${INSTALLDIR}/Browsers/intellinux/nppdf.so /opt/netscape/plugins
	
	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10acroread5

	#mozilla compatibility contributed by m3thos@netcabo.pt(Miguel Sousa Filipe)
	use mozilla && ( \
		dodir /usr/lib/mozilla/plugins
		dosym \
			${INSTALLDIR}/Browsers/intellinux/nppdf.so \
				/usr/lib/mozilla/plugins/nppdf.so
	)
}
