# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/jircii/jircii-14.ebuild,v 1.3 2004/10/31 17:27:57 swegener Exp $

DESCRIPTION="jIRCii - IRC client written in Java"
HOMEPAGE="http://jirc.hick.org/"
SRC_URI="http://jirc.hick.org/download/jerkr${PV}.tgz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/jre"
DEPEND=""

S=${WORKDIR}/jIRCii

src_compile() {
	true
}

src_install() {
	insinto /usr/share/jircii
	doins jerk.jar || die "doins failed"

	cat >${T}/jircii <<EOF
#!/bin/bash
exec java -jar /usr/share/jircii/jerk.jar
EOF
	dobin ${T}/jircii || die "dobin failed"

	dodoc readme.txt whatsnew.txt docs/*.pdf extra/*.irc || die "dodoc failed"
}
