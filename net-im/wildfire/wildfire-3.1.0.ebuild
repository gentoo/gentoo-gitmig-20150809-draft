# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/wildfire/wildfire-3.1.0.ebuild,v 1.1 2006/10/16 21:00:37 humpback Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Wildfire Jabber server"
HOMEPAGE="http://jivesoftware.org/messenger/"
SRC_URI="http://www.jivesoftware.org/builds/wildfire/${PN//-/_}_src_${PV//./_}.tar.gz"
RESTRICT=""
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="doc"

# For transports
PROVIDE="virtual/jabber-server"

RDEPEND=" >=virtual/jre-1.5 "
# Doesn't build against Java 1.6 due to changes in JDBC API
DEPEND="net-im/jabber-base
		=virtual/jdk-1.5*
		dev-java/ant
		dev-java/ant-contrib
		>=dev-java/commons-net-1.4"

S=${WORKDIR}/${PN//-/_}_src

pkg_setup() {
	if [ -f /etc/env.d/98wildfire ]; then
		einfo "This is an upgrade"
	else
		ewarn "If this is an upgrade stop right ( CONTROL-C ) and run the command:"
		ewarn "echo 'CONFIG_PROTECT=\"/opt/wildfire/resources/security/\"' > /etc/env.d/98wildfire "
		ewarn "For more info see bug #139708"
		sleep 10
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-for.patch
	# TODO should replace jars in build/lib with ones packaged by us -nichoj
}

src_compile() {
	# Jikes doesn't support -source 1.5
	java-pkg_filter-compiler jikes

	eant -f build/build.xml jar plugins $(use_doc)
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
	dodir /etc/env.d/
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
