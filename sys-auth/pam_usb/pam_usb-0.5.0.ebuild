# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_usb/pam_usb-0.5.0.ebuild,v 1.6 2012/05/04 18:57:21 jdhore Exp $

EAPI=4
inherit eutils pam toolchain-funcs

DESCRIPTION="A pam module to provide authentication using USB device"
HOMEPAGE="http://pamusb.org/"
SRC_URI="mirror://sourceforge/pamusb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# FIXME: pmount: http://bugs.gentoo.org/show_bug.cgi?id=358935#c5
COMMON_DEPEND="dev-libs/libxml2
	sys-apps/dbus
	virtual/pam"
RDEPEND="${COMMON_DEPEND}
	dev-python/celementtree
	dev-python/dbus-python
	dev-python/pygobject:2
	sys-apps/pmount
	sys-fs/udisks:0"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

src_prepare() {
	# FIXME: push upstream: http://bugs.gentoo.org/show_bug.cgi?id=358935#c6
	epatch "${FILESDIR}"/${P}-openpam.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DOCS_DEST="${D}/usr/share/doc/${PF}" \
		PAM_USB_DEST="${D}/$(getpam_mod_dir)" \
		install

	dodoc ChangeLog README.md
}
