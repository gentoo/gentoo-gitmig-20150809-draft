# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_usb/pam_usb-0.3.0.ebuild,v 1.2 2004/07/23 14:15:19 scox Exp $

inherit eutils

DESCRIPTION="A PAM module that enables authentication using an USB-Storage device (such as an USB Pen) through DSA private/public keys."
SRC_URI="http://www.pamusb.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.pamusb.org/"

IUSE="pam ssl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64"

RDEPEND="sys-libs/pam"
DEPEND="ssl? ( dev-libs/openssl )
	sys-libs/pam
	sys-apps/hotplug-base"

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir /lib/security /usr/bin /usr/share/man/man1
	dodir /etc/hotplug.d /etc/pam.d /etc/pam_usb

	einstall DESTDIR=${D} || die "einstall failed"
	dodoc AUTHORS COPYING Changelog README TODO
}
