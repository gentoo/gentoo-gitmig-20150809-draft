# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/kylixlibs3-borqt/kylixlibs3-borqt-3.0.ebuild,v 1.1 2003/03/04 22:07:21 bass Exp $

S="${WORKDIR}/kylixlibs3-borqt"
DESCRIPTION="Kylix 3 OE libraries"
SRC_URI="mirror://sourceforge/kylixlibs/kylixlibs3-borqt-3.0-2.tar.gz"
HOMEPAGE="kylixlibs.sf.net"
LICENSE="GPL-2"
DEPEND="x11-libs/qt"
RDEPEND="${RDEPEND}"
SLOT="0"
KEYWORDS="~x86"

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
	einfo "If is the first time that you install it"
	einfo "you need run:"
	einfo "ebuild /var/db/pkg/x11-libs/kylixlibs3-borqt-3.0/kylixlibs3-borqt-3.0.ebuild config"
}
pkg_config() {
	grep -q "^/usr/lib/kylix3\$" /etc/ld.so.conf
	if [ $? == 1 ]; then
	  echo /opt/kylix3 >> /etc/ld.so.conf
	fi
	ldconfig
}
