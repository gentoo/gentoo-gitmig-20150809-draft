# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/hotwayd/hotwayd-0.8.ebuild,v 1.2 2004/07/28 21:14:19 langthang Exp $

inherit eutils

DESCRIPTION="Hotmail to pop3 deamon"
HOMEPAGE="http://hotwayd.sourceforge.net/"
SRC_URI="mirror://sourceforge/hotwayd/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="sys-apps/xinetd
	dev-libs/libxml2"

src_compile() {
	epatch ${FILESDIR}/${P}-amd64.patch || die "epatch ${P}-amd64.patch failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	# The original make install is broken, since it also tries to install 
	# the libghttp files. This is not needed, since this library is statically
	# linked into the executable.
	# Lets just copy the (one) file manually...
	dosbin hotwayd

	dodoc AUTHORS NEWS README

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${P}.xinetd hotwayd
}

pkg_postinst () {
	einfo "----------------------------------------------------------------"
	einfo " By default daemons that use xinetd are not started "
	einfo "     automatically in gentoo"
	einfo " To activate do the following steps: "
	einfo " - Edit the file /etc/xinetd.d/hotwayd and change disable "
	einfo "   from yes to no "
	einfo " - Add the following line to /etc/services: "
	einfo "   hotwayd         110/tcp "
	einfo " - Note: if you already have a daemon serving port 110 (the "
	einfo "   default pop3 port); then change the port number to something "
	einfo "   else; also change the port number in hotwayd "
	einfo " - If you already had xinetd up and running, restart with "
	einfo "   # /etc/init.d/xinetd restart "
	einfo "   or "
	einfo "   If the emerge also pulled in the xinetd package for you, do "
	einfo "   # rc-update add xinetd default "
	einfo "   # /etc/init.d/xinetd start "
	einfo "-----------------------------------------------------------------"
}
