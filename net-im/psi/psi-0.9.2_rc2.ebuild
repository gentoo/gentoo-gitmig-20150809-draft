# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.9.2_rc2.ebuild,v 1.1 2004/05/24 11:37:30 humpback Exp $

IUSE="kde ssl crypt"
MY_PVR="0.9.2-test2"
S=${WORKDIR}/psi-${MY_PVR}
QV="2.0"
SRC_URI="http://psi.affinix.com/beta/psi-${MY_PVR}.tar.bz2"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6c >=app-crypt/qca-tls-1.0 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	>=x11-libs/qt-3"

src_compile() {
	use kde || myconf="${myconf} --disable-kde"
	./configure --prefix=/usr $myconf || die
	addwrite "$HOME/.qt"
	addwrite "$QTDIR/etc/settings"
	emake || die
}

src_install() {
	make INSTALL_ROOT="${D}" install
}
