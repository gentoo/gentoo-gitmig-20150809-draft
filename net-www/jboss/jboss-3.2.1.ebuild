# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/jboss/jboss-3.2.1.ebuild,v 1.2 2003/05/28 08:15:36 mkennedy Exp $

MY_P="${P}-src"

DESCRIPTION="The Open Source J2EE app server implementation"
SRC_URI="mirror://sourceforge/jboss/${MY_P}.tgz"
HOMEPAGE="http://www.jboss.org"
LICENSE="LGPL-2"
IUSE="doc"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	dev-java/ant"

INSTALL_DIR=/opt/${P}

S=${WORKDIR}/${MY_P}

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	cd build
	sh build.sh || die
}

src_install() {
	dodir ${INSTALL_DIR}
	dodir ${INSTALL_DIR}/bin

	cp build/output/${PN}-${PV}/bin/run.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/shutdown.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/run.jar ${D}/${INSTALL_DIR}/bin
	cp build/output/${PN}-${PV}/bin/shutdown.jar ${D}/${INSTALL_DIR}/bin

	exeinto /etc/init.d
	doexe ${FILESDIR}/${PV}/init.d/jboss

	dodir /etc/conf.d
	cp ${FILESDIR}/${PV}/conf.d/jboss ${D}/etc/conf.d

	dodir /etc/env.d
	cp ${FILESDIR}/${PV}/env.d/50jboss ${D}/etc/env.d
	sed -i "s#@JBOSSPREFIX@#${INSTALL_DIR}#" ${D}/etc/env.d/50jboss

	einfo ">>> Setting up configuration files and library packages..."
	local dirs="build/output/${PN}-${PV}/server build/output/${PN}-${PV}/lib build/output/${PN}-${PV}/client"
	for i in $dirs ; do
		cp -a $i ${D}/${INSTALL_DIR}/
	done
	cp ${FILESDIR}/${PV}/log4j.xml ${D}/${INSTALL_DIR}/server/all/conf
	cp ${FILESDIR}/${PV}/log4j.xml ${D}/${INSTALL_DIR}/server/default/conf
	cp ${FILESDIR}/${PV}/log4j.xml ${D}/${INSTALL_DIR}/server/minimal/conf

	# We probably should not do this, because a wide variety of tools
	# assume everything under a common JBoss file system.

# 	einfo ">>> Installing client libraries..."
# 	local dirs="build/output/${PN}-${PV}/client/*"
# 	for i in $dirs ; do
# 		dojar $i
# 	done

	einfo ">>> Setting up documentation..."
	dodoc server/src/docs/LICENSE.txt ${FILESDIR}/README.gentoo
	if [ -n "`use doc`" ] ; then
		dohtml -a html,htm,png,gif,css,java -r build/output/${PN}-${PV}/docs/
	fi

	einfo ">>> Creating log directory..."
	dodir /var/log/jboss
	touch ${D}/var/log/jboss/.keep
}

pkg_postinst() {
	chown -R jboss ${INSTALL_DIR}/server
	chgrp -R jboss ${INSTALL_DIR}/server
	chown jboss /var/log/jboss
	chgrp jboss /var/log/jboss
	chmod -R g+w ${INSTALL_DIR}/server	

	einfo ""
	einfo "Access summary"
	einfo "--------------"
	einfo "  * User jboss and group jboss ownership for"
	einfo "    ${INSTALL_DIR}/server and higher and "
	einfo "    /var/log/jboss"
	einfo "  * User and group read/write permissions for"
	einfo "    ${INSTALL_DIR}/server and higher"
	einfo ""
	einfo "Gentoo specific documentation for JBoss is available at"
	einfo "/usr/share/doc/${P}/README.gentoo"
	einfo ""
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
