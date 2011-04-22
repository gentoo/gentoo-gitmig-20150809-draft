# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_usb/pam_usb-0.5.0.ebuild,v 1.1 2011/04/22 16:03:01 ssuominen Exp $

EAPI=4
inherit pam toolchain-funcs

DESCRIPTION="A pam module to provide authentication using USB device"
HOMEPAGE="http://pamusb.org/"
SRC_URI="mirror://sourceforge/pamusb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# FIXME: Why is pam_usb using pmount when it should be using udisks --mount?
COMMON_DEPEND="dev-libs/libxml2
	sys-apps/dbus
	virtual/pam"
RDEPEND="${COMMON_DEPEND}
	dev-python/celementtree
	dev-python/dbus-python
	dev-python/pygobject
	sys-apps/pmount
	sys-fs/udisks"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

src_compile() {
	tc-export CC
	emake
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DOCS_DEST="${D}/usr/share/doc/${PF}" \
		PAM_USB_DEST="${D}/$(getpam_mod_dir)" \
		install

	dodoc ChangeLog README.md
}
