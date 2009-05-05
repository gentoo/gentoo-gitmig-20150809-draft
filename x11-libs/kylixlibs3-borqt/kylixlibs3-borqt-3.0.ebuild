# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/kylixlibs3-borqt/kylixlibs3-borqt-3.0.ebuild,v 1.8 2009/05/05 08:14:15 ssuominen Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Kylix 3 OE libraries"
HOMEPAGE="http://kylixlibs.sf.net"
SRC_URI="mirror://sourceforge/kylixlibs/${P}-2.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="=x11-libs/qt-3*"
DEPEND="${RDEPEND}"

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
	einfo "emerge --config =${CATEGORY}/${PF}"
}

pkg_config() {
	grep -q "^/usr/lib/kylix3\$" /etc/ld.so.conf
	if [ $? == 1 ]; then
	  echo /opt/kylix3 >> /etc/ld.so.conf
	fi
	ldconfig
}
