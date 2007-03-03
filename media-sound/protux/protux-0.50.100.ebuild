# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.50.100.ebuild,v 1.1 2007/03/03 16:11:10 betelgeuse Exp $

inherit java-pkg-2

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://protux.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/releases/${P}.tar.gz"

IUSE="source"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}"

src_compile() {
	cd src
	ejavac -encoding latin1 $(find . -name "*.java")
	jar cf ${PN}.jar $(find . -name "*.class") || die
}

src_install() {
	java-pkg_dojar src/${PN}.jar
	dodoc AUTHORS BUGLIST ChangeLog COPYRIGHT INSTALL README TODO || die
	use source && java-pkg_dosrc src/org
	# pwd like this because it does not find resources otherwise
	java-pkg_dolauncher ${PN} \
		--main org.protux.Main \
		--pwd /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r resources || die
}
