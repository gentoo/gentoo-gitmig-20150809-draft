# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_jk2/mod_jk2-2.0.4.ebuild,v 1.2 2004/12/11 01:20:17 karltk Exp $

DESCRIPTION="JK2 module that is used to connect tomcat to apache2 using the ajp13 protocol"
HOMEPAGE="http://jakarta.apache.org/tomcat/connectors-doc/jk2/index.html"
SRC_URI="mirror://apache/jakarta/tomcat-connectors/jk2/source/jakarta-tomcat-connectors-jk2-${PV}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="=net-www/apache-2*
	>=virtual/jdk-1.4"
RDEPEND="=net-www/apache-2*
	>=virtual/jre-1.4"

S=${WORKDIR}/jakarta-tomcat-connectors-jk2-${PV}-src

src_compile() {
	cd ${S}/jk/native2
	econf --with-apxs2=/usr/sbin/apxs2 --with-jni --with-pcre
	emake || die "emake failed"
}
src_install() {
	cd ${S}/jk/native2
	dodoc CHANGES.txt README.txt INSTALL.txt

	cd ${S}/jk/build/jk2
	exeinto /usr/lib/apache2-extramodules/
	doexe apache2/mod_jk2.so
	doexe apache2/libjkjni.so

	einfo "Installing a Apache2 config for mod_jk (89_mod_jk2.conf)"
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/89_mod_jk2.conf
	insinto /etc/apache2/conf
	doins ${FILESDIR}/workers2.properties
}

pkg_postinst() {
	einfo
	einfo "Please add \"-D JK2\" to your /etc/conf.d/apache2 file to"
	einfo "allow apache2 to recognize and load the mod_jk2 module."
	einfo
	einfo "A basic workers2.properties file has been created in"
	einfo "/etc/apache2/conf/.  Modify it before loading mod_jk2."
	einfo
}
