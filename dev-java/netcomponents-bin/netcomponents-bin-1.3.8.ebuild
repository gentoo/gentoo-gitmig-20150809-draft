# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netcomponents-bin/netcomponents-bin-1.3.8.ebuild,v 1.1 2004/09/17 09:28:56 axxo Exp $

inherit java-pkg

DESCRIPTION="An Internet protocol suite Java library from OROa"
HOMEPAGE="http://www.savarese.org/oro/"
SRC_URI="http://www.savarese.org/oro/downloads/NetComponents-${PV}.tar.gz"
LICENSE="netcomponents"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND="virtual/jdk"

S=${WORKDIR}/NetComponents-${PV}a

src_compile() { :; }

src_install() {
	java-pkg_dojar NetComponents.jar
	use doc && dohtml -r doc/
}
