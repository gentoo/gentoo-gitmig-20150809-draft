# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xdoclet-bin/xdoclet-bin-1.2.1.ebuild,v 1.1 2004/08/30 18:42:16 zx Exp $

DESCRIPTION="XDoclet is a code generation engine."
SRC_URI="mirror://sourceforge/xdoclet/${P}.tgz"
HOMEPAGE="http://xdoclet.sf.net"
LICENSE="Apache-1.1"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~sparc"
RDEPEND=" || ( >=virtual/jre-1.4 >=virtual/jdk-1.4 )"
RESTRICT="nomirror"

S=${WORKDIR}/${PN%%-bin}-${PV}

src_install() {
	dojar lib/*.jar
	use doc && dohtml -r docs/*
}
