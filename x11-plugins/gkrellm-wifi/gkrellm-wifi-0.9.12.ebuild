# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-wifi/gkrellm-wifi-0.9.12.ebuild,v 1.11 2007/04/07 21:35:46 genstef Exp $

inherit multilib

DESCRIPTION="A GKrellM2 plug-in for monitoring the link quality of your wireless LAN cards"
HOMEPAGE="http://dev.gentoo.org/~brix/files/gkrellm-wifi/"
SRC_URI="http://dev.gentoo.org/~brix/files/gkrellm-wifi/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND=">=app-admin/gkrellm-2.1.12
		>=net-wireless/wireless-tools-22"

src_compile() {
	CFLAGS="$CFLAGS -I/usr/include/"
	emake || die
}

src_install() {
	exeinto /usr/$(get_libdir)/gkrellm2/plugins
	doexe gkrellm-wifi.so
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THEMING TODO
}
