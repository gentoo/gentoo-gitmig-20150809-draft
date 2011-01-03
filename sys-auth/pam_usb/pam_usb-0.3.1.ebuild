# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_usb/pam_usb-0.3.1.ebuild,v 1.4 2011/01/03 10:01:03 ssuominen Exp $

inherit eutils

DESCRIPTION="pam_usb provides hardware authentication for Linux using ordinary USB Flash Drives."
SRC_URI="http://www.pamusb.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.pamusb.org/"

IUSE="pam ssl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc x86"

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

	einstall DESTDIR="${D}" || die "einstall failed"
	dodoc AUTHORS Changelog README TODO
}
