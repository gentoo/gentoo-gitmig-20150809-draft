# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/jdk/jdk-1.2.2.ebuild,v 1.3 2001/05/01 18:29:05 achim Exp $

P=jdk-1.2.2
A=j2sdk-1.2.2-FCS-linux-i386-glibc-2.1.3.tar.bz2
S=${WORKDIR}/jdk1.2.2
DESCRIPTION="Blackdown JDK 1.2.2"
SRC_URI="ftp://gd.tuwien.ac.at/opsys/linux/java/JDK-1.2.2/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org/java-linux.html"

DEPEND=">=sys-apps/bash-2.04 
	>=sys-libs/glibc-2.1.3
	virtual/x11"

src_compile() {                           
  cd ${S}
}

src_install() {                               
  dodir /opt/jdk-1.2.2
  cp -a ${S}/bin ${D}/opt/jdk-1.2.2
  cp -a ${S}/demo ${D}/opt/jdk-1.2.2
  cp -a ${S}/include ${D}/opt/jdk-1.2.2
  cp -a ${S}/lib ${D}/opt/jdk-1.2.2
  cp -a ${S}/jre ${D}/opt/jdk-1.2.2
  cp    ${S}/src.jar ${D}/opt/jdk-1.2.2
  into /usr
  dodoc COPYRIGHT LICENSE README README.linux 
  docinto html
  dodoc README.html
}

pkg_postinst () {
  ln -s ${ROOT}/opt/jdk-1.2.2 ${ROOT}/opt/java
}


