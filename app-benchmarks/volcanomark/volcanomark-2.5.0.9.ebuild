# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/volcanomark/volcanomark-2.5.0.9.ebuild,v 1.1 2004/02/09 02:50:40 dragonheart Exp $

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
	echo "No unpack required"
}

src_install() {
	dodir /opt/${PN}
	java -classpath ${DISTDIR} vmark2_5_0_9 -o ${D}/opt/${PN}
	chmod 755 ${D}/opt/${PN}/*.sh
	sed -i -e "s#^host=.*#host=`hostname`#" ${D}/opt/${PN}/startup.sh
	sed -i -e "s#^./startup.sh#/opt/${PN}/startup.sh#g" ${D}/opt/${PN}/*.sh
}

pkg_postinst() {
	ewarn "The vendor provided installation script is somewhat broken!"
	einfo
	einfo "startup.sh will need to be edited with the correct"
	einfo "path to the desired java installations you would"
	einfo "like to benchmark."
}
