# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-4.05-r1.ebuild,v 1.1 2001/10/06 15:30:15 danarmak Exp $

A=linux-ar-405.tar.gz
S=${WORKDIR}/ILINXR.install
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/4.x/${A}"
HOMEPAGE="http://www.adobe.com/products/acrobat/"

DEPEND=""
RDEPEND="virtual/x11"

src_compile() {

  tar xvf ILINXR.TAR
  tar xvf READ.TAR 
  sed -e "s:REPLACE_ME:/usr/lib/Acrobat4/Reader:" \
	bin/acroread.sh > acroread
}

src_install () {

  dodir /usr/lib/Acrobat4
  for i in Browsers Reader Resource
  do
    cp -a ${S}/${i} ${D}/usr/lib/Acrobat4
  done
  exeinto /usr/bin
  doexe acroread
  dodoc ReadMe LICREAD.TXT
  dodir /opt/netscape/plugins
  dosym /usr/lib/Acrobat4/Browsers/intellinux/nppdf.so /opt/netscape/plugins
}

