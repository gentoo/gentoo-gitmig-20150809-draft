# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-4.05-r4.ebuild,v 1.3 2002/05/22 11:09:48 seemant Exp $

MY_P=linux-ar-405
S=${WORKDIR}/ILINXR.install
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/4.x/${MY_P}.tar.gz"
HOMEPAGE="http://www.adobe.com/products/acrobat/"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11"

LICENSE="Adobe"

src_unpack() {

	unpack ${A}
	cd ${S}
	tar xvf ILINXR.TAR
	tar xvf READ.TAR 
}

src_compile () {
	
	tar xvf ILINXR.TAR
	tar xvf READ.TAR

	sed -e "s:REPLACE_ME:/opt/Acrobat4/Reader:" \
		bin/acroread.sh > acroread
}

src_install () {

	dodir /opt/Acrobat4
	for i in Browsers Reader Resource
	do
		cp -a ${S}/${i} ${D}/opt/Acrobat4
	done
	exeinto /opt/Acrobat4
	doexe acroread
	dodoc ReadMe LICREAD.TXT
	into /opt/netscape/plugins
	dosym /opt/Acrobat4/Browsers/intellinux/nppdf.so /opt/netscape/plugins
	insinto /etc/env.d
	doins ${FILESDIR}/10acroread

	#mozilla compatibility contributed by m3thos@netcabo.pt(Miguel Sousa Filipe)
	if use mozilla; then
		into /usr/lib/mozilla/plugins
		dosym	\
			/opt/Acrobat4/Browsers/intellinux/nppdf.so	\
			/usr/lib/mozilla/plugins/nppdf.so
	fi
}
