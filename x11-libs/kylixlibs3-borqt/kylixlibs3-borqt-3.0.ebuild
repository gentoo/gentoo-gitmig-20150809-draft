# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/kylixlibs3-borqt/kylixlibs3-borqt-3.0.ebuild,v 1.6 2005/07/28 21:10:20 caleb Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Kylix 3 OE libraries"
HOMEPAGE="http://kylixlibs.sf.net"
SRC_URI="mirror://sourceforge/kylixlibs/${P}-2.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="=x11-libs/qt-3*"

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
}

pkg_postinst() {
	einfo "If is the first install of ${P}"
	einfo "you need to run:"
	einfo "ebuild /var/db/pkg/x11-libs/${P}/${P}.ebuild config"
}

pkg_config() {
	grep -q "^/usr/lib/kylix3\$" /etc/ld.so.conf
	if [ $? == 1 ]; then
	  echo /opt/kylix3 >> /etc/ld.so.conf
	fi
	ldconfig
}
