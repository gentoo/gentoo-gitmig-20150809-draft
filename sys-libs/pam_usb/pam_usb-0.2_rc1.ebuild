# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam_usb/pam_usb-0.2_rc1.ebuild,v 1.1 2003/11/18 20:04:42 hhg Exp $

inherit eutils

DESCRIPTION="A PAM module that enables authentication using an USB-Storage device (such as an USB Pen) through DSA private/public keys."
SRC_URI="http://www.sig11.org/~al/pam_usb/${P}.tar.gz"
HOMEPAGE="http://www.sig11.org/~al/pam_usb"

IUSE="pam ssl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

RDEPEND="sys-libs/pam"
DEPEND="ssl? ( dev-libs/openssl )
	sys-libs/pam"

src_compile() {
	emake || die "make failed"
}

src_install() {
	dodir /lib/security /usr/bin /usr/share/man/man1

	einstall DESTDIR=${D} || die "einstall failed"
	dodoc AUTHORS COPYING Changelog README TODO
}
