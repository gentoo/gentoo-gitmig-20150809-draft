# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jive-messenger/jive-messenger-2.2.0.ebuild,v 1.1 2005/08/30 00:57:48 lostlogic Exp $

inherit java-utils

DESCRIPTION="Jive Messenger Jabber server"

HOMEPAGE="http://jivesoftware.org/messenger/"

SRC_URI="http://jivesoftware.org/builds/messenger/${PN//-/_}_src_${PV//./_}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/jdk-1.5 dev-java/ant"

S=${WORKDIR}/${PN//-/_}_src

src_compile() {
	java-utils_vm-version-sufficient
	ant -f build/build.xml plugins jar javadoc
}

src_install() {
	dodir /opt
	mv target ${D}/opt/jive_messenger
	fowners -R root:root /opt/jive_messenger
	doinitd ${FILESDIR}/init.d/jive
}

pkg_postinst() {
	enewgroup jive
	enewuser jive -1 /bin/false /dev/null jive
}
