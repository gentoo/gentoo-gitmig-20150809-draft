# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/jboss/jboss-3.0.6.ebuild,v 1.3 2003/09/06 01:54:08 msterret Exp $

MY_P="jboss-3.0.6-src"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Open Source J2EE app server implementation"
SRC_URI="mirror://sourceforge/jboss/${MY_P}.tgz"
HOMEPAGE="http://www.jboss.org"
LICENSE="LGPL-2"
IUSE="doc"

RDEPEND=">=virtual/jdk-1.3"

DEPEND="${RDEPEND}
	dev-java/ant"

SLOT="0"
KEYWORDS="~x86"

INSTALL_DIR=/opt/${P}

src_unpack() {
	unpack $MY_P.tgz
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-connector.patch || die
}

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	cd build
	sh build.sh || die
}

pkg_preinst() {
	einfo ">>> Adding user and group for JBoss"
	if ! groupmod jboss ; then
		groupadd jboss || die "problem adding jboss group"
	fi
	if ! id jboss ; then
		useradd jboss -g jboss || die "problem adding jboss user"
	fi
}

src_install() {

	dodir ${INSTALL_DIR}
	dodir ${INSTALL_DIR}/bin

	cp build/output/${PN}-${PV}/bin/run.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/shutdown.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/run.jar ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/shutdown.jar ${D}/${INSTALL_DIR}/bin

	exeinto /etc/init.d
	doexe ${FILESDIR}/init.d/jboss
	exeinto /etc/conf.d
	sed -e "s#@jbossprefix@#/opt/${P}#" ${FILESDIR}/conf.d/jboss >${D}/etc/conf.d/jboss

	einfo ">>> Setting up configuration files and library packages..."
	local dirs="build/output/${PN}-${PV}/server build/output/${PN}-${PV}/lib"
	for i in $dirs ; do
	 	cp -a $i ${D}/${INSTALL_DIR}/
	done
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/all/conf
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/default/conf
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/minimal/conf

	einfo ">>> Installing client libraries..."
	local dirs="build/output/${PN}-${PV}/client/*"
	for i in $dirs ; do
		dojar $i
	done

	einfo ">>> Setting up documentation..."
	dodoc build/output/${PN}-${PV}/docs/LICENSE.txt ${FILESDIR}/README.gentoo
	if [ -n "`use doc`" ] ; then
		dohtml -a html,htm,png,gif,css,java -r build/output/${PN}-${PV}/docs/
	fi

	einfo ">>> Creating log directory..."
	dodir /var/log/jboss
	touch ${D}/var/log/jboss/.keep
}

pkg_postinst() {
	einfo ">>> Assigning access rights..."
	chown -R jboss ${INSTALL_DIR}/server
	chgrp -R jboss ${INSTALL_DIR}/server
	chown jboss /var/log/jboss
	chgrp jboss /var/log/jboss
}

pkg_postrm() {
	einfo ">>> Removing user and group for JBoss"
	if ! groupmod jboss ; then
		groupdel jboss
	fi
	if ! id jboss ; then
		userdel jboss
	fi
}
