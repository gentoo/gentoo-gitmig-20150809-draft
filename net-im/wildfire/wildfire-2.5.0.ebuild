# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/wildfire/wildfire-2.5.0.ebuild,v 1.1 2006/02/26 13:36:31 humpback Exp $

inherit java-utils

DESCRIPTION="Wildfire Jabber server"
HOMEPAGE="http://jivesoftware.org/messenger/"
SRC_URI="http://www.jivesoftware.org/servlet/download/builds/wildfire/${PN//-/_}_src_${PV//./_}.tar.gz"
RESTRICT=""
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="doc"

# For transports
PROVIDE="virtual/jabber-server"

RDEPEND="|| ( >=virtual/jre-1.5 >=virtual/jdk-1.5 )"
DEPEND="net-im/jabber-base
>=virtual/jdk-1.5 dev-java/ant"

S=${WORKDIR}/${PN//-/_}_src


src_compile() {
	java-utils_vm-version-sufficient
	ant -f build/build.xml || die
	ant -f build/build.xml jar || die

	einfo
	einfo "Building plugins..."
	einfo
	ant -f build/build.xml plugins || die
}

src_install() {
	dodir /opt/wildfire

	doinitd ${FILESDIR}/init.d/wildfire
	doconfd ${FILESDIR}/conf.d/wildfire

	dodir /opt/wildfire/conf
	insinto /opt/wildfire/conf
	newins target/conf/wildfire.xml wildfire.xml.sample

	dodir /opt/wildfire/logs
	keepdir /opt/wildfire/logs

	dodir /opt/wildfire/lib
	insinto /opt/wildfire/lib
	doins target/lib/*

	dodir /opt/wildfire/plugins
	insinto /opt/wildfire/plugins
	doins -r target/plugins/*

	dodir /opt/wildfire/resources
	insinto /opt/wildfire/resources
	doins -r target/resources/*

	if use doc; then
		dohtml -r documentation/docs/*
	fi
	dodoc documentation/dist/*

	#Protect ssl key on upgrade
	echo 'CONFIG_PROTECT="/opt/wildfire/resources/security/"' > ${D}/etc/env.d/98wildfire
}

pkg_postinst() {
	chown -R jabber:jabber /opt/wildfire

	ewarn If this is a new install, please edit /opt/wildfire/conf/wildfire.xml.sample
	ewarn and save it as /opt/wildfire/conf/wildfire.xml
	einfo
	ewarn The following must be be owned or writable by the jabber user.
	einfo /opt/wildfire/conf/wildfire.xml
}
