# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpi4asus/acpi4asus-0.27.ebuild,v 1.3 2004/09/09 16:53:11 kugelfang Exp $

DESCRIPTION="Acpi daemon to control ASUS Laptop Hotkeys"
HOMEPAGE="http://sourceforge.net/projects/acpi4asus"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_compile() {
	make -C asus_acpid || die
	make -C asus_acpid man || die
}

src_install() {
	dobin asus_acpid/asus_acpid
	doman asus_acpid/asus_acpid.8.gz

	dodoc README Changelog

	dodir /usr/share/${PN}/samples
	insinto /usr/share/${PN}/samples
	doins samples/*.{sh,pl}

	dodir /usr/share/${PN}/samples/events
	insinto /usr/share/${PN}/samples/events
	doins samples/events/*
}

pkg_postinst() {
	einfo
	einfo "Don't forget to create your ~/.asus_acpi,"
	einfo "see /ush/share/docs/${P}/README for details"
	ewarn "You mast have 'ASUS/Medion Laptop Extras' kernel modules"
	einfo
}
