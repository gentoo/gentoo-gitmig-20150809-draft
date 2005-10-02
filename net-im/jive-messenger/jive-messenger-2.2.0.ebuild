# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jive-messenger/jive-messenger-2.2.0.ebuild,v 1.4 2005/10/02 14:55:46 flameeyes Exp $

inherit java-utils

DESCRIPTION="Jive Messenger Jabber server"

HOMEPAGE="http://jivesoftware.org/messenger/"

SRC_URI="http://jivesoftware.org/builds/messenger/${PN//-/_}_src_${PV//./_}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

RDEPEND="|| ( >=virtual/jre-1.5 >=virtual/jdk-1.5 )"
DEPEND=">=virtual/jdk-1.5 dev-java/ant"

S=${WORKDIR}/${PN//-/_}_src

src_compile() {
	java-utils_vm-version-sufficient
	ant -f build/build.xml || die
}

src_install() {
	dodir /opt
	mv target ${D}/opt/jive_messenger
	fowners -R root:0 /opt/jive_messenger
	doinitd ${FILESDIR}/init.d/jive
}

pkg_postinst() {
	enewgroup jive
	enewuser jive -1 -1 /dev/null jive
	chown -R jive:jive /opt/jive_messenger/logs/
	chown -R jive:jive /opt/jive_messenger/conf/
}
