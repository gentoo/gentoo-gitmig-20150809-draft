# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/volcanomark/volcanomark-2.5.0.9.ebuild,v 1.2 2004/02/09 03:32:47 dragonheart Exp $

DESCRIPTION="Java server benchmark utility"
HOMEPAGE="http://www.volano.com/benchmarks.html"
SRC_URI="http://www.volano.com/pub/vmark2_5_0_9.class"
LICENSE="Volcano Apache-1.1"

# Below because of licensing.
RESTRICT="nomirror"

SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/jre
	>=sys-apps/sed-4
	sys-apps/net-tools"

RDEPEND="virtual/jre"

src_unpack() {
	einfo "No unpack required"
}

src_install() {
	dodir /opt/${PN}
	java -classpath ${DISTDIR} vmark2_5_0_9 -o ${D}/opt/${PN}
	chmod 755 ${D}/opt/${PN}/*.sh
	sed -i -e "s#^host=.*#cd /opt/${PN}\nhost=`hostname`#" \
		-e 's:"$java":java:g' \
		-e 's:! -f: -z :' \
		${D}/opt/${PN}/startup.sh

	sed -i -e "s#^./startup.sh#/opt/${PN}/startup.sh#g" ${D}/opt/${PN}/*.sh

	keepdir /opt/${PN}/logs
}

pkg_postinst() {

	ewarn "The vendor provided installation script is somewhat broken!"
	einfo
	einfo "startup.sh was patched to allow the use of the current JVM as"
	einfo "selected by java-config. This means that regardless of the"
	einfo "Java vendor you specify to ${PN}, it will STILL use the default"
	einfo "JVM configured via java-config"
	einfo
	einfo "Just make sure that when you run ${PN}, the Java vendor you specify"
	einfo "matches up with what java-config is configured for. Otherwise specific"
	einfo "vendor specific options runtime may not work."
	einfo
	einfo "Remember to check the host property in startup.sh to the host that is"
	einfo "running the server"

}
