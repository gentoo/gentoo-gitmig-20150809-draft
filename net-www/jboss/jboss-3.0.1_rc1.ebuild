# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/jboss/jboss-3.0.1_rc1.ebuild,v 1.6 2003/09/06 01:54:08 msterret Exp $

MY_P="jboss-3.0.1RC1-src"
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Java app-server reference implementation"
SRC_URI=" http://belnet.dl.sourceforge.net/sourceforge/jboss/${MY_P}.tgz"
HOMEPAGE="http://www.jboss.org"
LICENSE="LGPL-2.1"

RDEPEND=">=virtual/jdk-1.3"

DEPEND="${RDEPEND}
	dev-java/ant"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

INSTALL_DIR=/usr/lib/${P}

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	cd build
	sh build.sh all || die
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

	cp build/output/jboss-3.0.1RC1/bin/run.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/jboss-3.0.1RC1/bin/shutdown.sh ${D}/${INSTALL_DIR}/bin
	cp build/output/jboss-3.0.1RC1/bin/run.jar ${D}/${INSTALL_DIR}/bin
	cp build/output/jboss-3.0.1RC1/bin/shutdown.jar ${D}/${INSTALL_DIR}/bin

	exeinto /etc/init.d
	doexe ${FILESDIR}/init.d/jboss
	exeinto /etc/conf.d
	sed -e "s#@jbossprefix@#/usr/lib/${P}#" ${FILESDIR}/conf.d/jboss >${D}/etc/conf.d/jboss

	einfo ">>> Setting up configuration files and library packages..."
	local dirs="build/output/jboss-3.0.1RC1/server build/output/jboss-3.0.1RC1/lib"
	for i in $dirs ; do
	 	cp -a $i ${D}/${INSTALL_DIR}/
	done
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/all/conf
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/default/conf
	cp ${FILESDIR}/log4j.xml ${D}/${INSTALL_DIR}/server/minimal/conf

	einfo ">>> Installing client libraries..."
	local dirs="build/output/jboss-3.0.1RC1/client/*"
	for i in $dirs ; do
		dojar $i
	done

	einfo ">>> Setting up documentation..."
	dodoc build/output/jboss-3.0.1RC1/docs/LICENSE.txt ${FILESDIR}/README.gentoo
	dohtml -a html,htm,png,gif,css,java -r build/output/jboss-3.0.1RC1/docs/

	einfo ">>> Creating log directory..."
	dodir /var/log/jboss
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
