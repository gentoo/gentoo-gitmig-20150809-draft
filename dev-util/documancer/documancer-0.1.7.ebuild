# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/documancer/documancer-0.1.7.ebuild,v 1.7 2005/03/23 16:16:34 seemant Exp $

DESCRIPTION="Programmer's documentation reader with very fast fulltext searching"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://documancer.sourceforge.net"
KEYWORDS="~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=www-client/mozilla-1.0
	>=x11-libs/gtk+-2.0
	>=dev-lang/python-2.1
	>=www-apps/swish-e-2.2.2
	dev-lang/perl
	net-misc/wget"

pkg_setup () {
	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.3_beta compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!!"
	fi
}

src_compile() {
	cd ${S}
	./autogen.sh
	./configure --enable-gtk2 --prefix=/usr || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
	     install || die
	cp ${FILESDIR}/documancer.backend ${D}/usr/bin/

	dodoc AUTHORS Hacking.txt COPYING FAQ NEWS README TODO
}
