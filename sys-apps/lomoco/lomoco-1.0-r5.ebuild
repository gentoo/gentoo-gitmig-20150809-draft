# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lomoco/lomoco-1.0-r5.ebuild,v 1.1 2011/03/27 19:38:42 flameeyes Exp $

EAPI="4"

inherit autotools eutils multilib

DESCRIPTION="Lomoco can configure vendor-specific options on Logitech USB mice."
HOMEPAGE="http://www.lomoco.org/"
SRC_URI="http://www.lomoco.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"
RDEPEND="${DEPEND}
	!<sys-fs/udev-114"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo-hardware-support.patch
	epatch "${FILESDIR}"/${P}-updated-udev.patch
	eautoreconf
}

src_compile() {
	emake || die "make failed"
	awk -f udev/toudev.awk < src/lomoco.c > udev/40-lomoco.rules \
		|| die "failed to create udev rules"
	sed -i -e 's:RUN="lomoco":RUN+="lomoco-helper":' \
		udev/40-lomoco.rules || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	insinto /$(get_libdir)/udev/rules.d
	doins udev/40-lomoco.rules

	insinto /etc
	doins "${FILESDIR}"/lomoco.conf

	exeinto /usr/libexec/
	newexe udev/udev.lomoco lomoco-helper

	exeinto /etc/pm/sleep.d
	newexe "${FILESDIR}"/lomoco-pm-utils lomoco

	dodoc AUTHORS ChangeLog NEWS README
}
