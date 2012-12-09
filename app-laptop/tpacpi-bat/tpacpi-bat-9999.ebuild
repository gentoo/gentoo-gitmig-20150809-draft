# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tpacpi-bat/tpacpi-bat-9999.ebuild,v 1.1 2012/12/09 21:29:30 ottxor Exp $

EAPI=5

inherit eutils git-2

DESCRIPTION="Control battery thresholds of recent ThinkPads, which are not supported by tp_smapi"
HOMEPAGE="https://github.com/teleshoes/tpbattstat-applet"
SRC_URI=""
EGIT_REPO_URI="git://github.com/teleshoes/tpbattstat-applet.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

IUSE=""

DEPEND=""
RDEPEND="sys-power/acpi_call
	dev-lang/perl"

src_install() {
	dodoc README.md AUTHORS
	dobin tpacpi-bat
	newinitd "${FILESDIR}"/${PN}.initd.0 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd.0 ${PN}
}
