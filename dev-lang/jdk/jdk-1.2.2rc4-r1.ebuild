# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/jdk/jdk-1.2.2rc4-r1.ebuild,v 1.1 2000/08/07 18:11:23 achim Exp $

P=jdk-1.2.2
A=jdk-1.2.2-RC4-linux-i386-glibc-2.1.2.tar.bz2
S=${WORKDIR}/jdk1.2.2
CATEGORY="dev-lang"
DESCRIPTION="Blackdown JDK 1.2.2"
SRC_URI="ftp://gd.tuwien.ac.at/opsys/linux/java/JDK-1.2.2/i386/rc4/jdk-1.2.2-RC4-linux-i386-glibc-2.1.2.tar.bz2"
HOMEPAGE="http://www.blackdown.org/java-linux.html"

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
  dodoc COPYRIGHT LICENSE README README.PRE-RELEASE README.linux 
  docinto html
  dodoc README.html
}

pkg_postinst () {
  ln -s ${ROOT}/opt/jdk-1.2.2 ${ROOT}/opt/java
}


