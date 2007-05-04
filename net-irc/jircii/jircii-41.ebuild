# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/jircii/jircii-41.ebuild,v 1.1 2007/05/04 18:15:36 armin76 Exp $

inherit java-pkg-2

DESCRIPTION="jIRCii - IRC client written in Java"
HOMEPAGE="http://jirc.hick.org/"
SRC_URI="http://jirc.hick.org/download/jerkb${PV}.tgz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=""

S="${WORKDIR}"/jIRCii

src_compile() {
	true
}

src_install() {
	java-pkg_dojar jerk.jar || die "java-pkg_dojar failed"
	java-pkg_dolauncher jircii --jar "${JAVA_PKG_JARDEST}"/jerk.jar || die "java-pkg_dolauncher"

	dodoc readme.txt whatsnew.txt docs/*.pdf extra/*.irc || die "dodoc failed"
}
