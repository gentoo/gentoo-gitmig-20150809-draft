# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/kylixlibs3-borqt/kylixlibs3-borqt-3.0-r1.ebuild,v 1.1 2003/06/09 16:02:24 darkspecter Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Kylix 3 OE libraries"
HOMEPAGE="http://kylixlibs.sf.net"
SRC_URI="mirror://sourceforge/kylixlibs/${P}-2.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="x11-libs/qt"

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/kylix3
	insinto /opt/kylix3
	doins libborqt-6.9.0-qt2.3.so
	insinto /opt/kylix3
	newins libborqt-6.9.0-qt2.3.so libborqt-6.9-qt2.3.so
	dodoc README

	echo "LDPATH=/opt/kylix3" > 99kylixlibs
	insinto /etc/env.d
	doins 99kylixlibs
}

