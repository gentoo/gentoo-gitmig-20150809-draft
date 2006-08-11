# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/udept/udept-0.5.95.2-r1.ebuild,v 1.1 2006/08/11 22:16:32 fuzzyray Exp $

inherit bash-completion

DESCRIPTION="A Portage analysis toolkit"
HOMEPAGE="http://catmur.co.uk/gentoo/udept"
SRC_URI="http://files.catmur.co.uk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-apps/portage"
RDEPEND=${DEPEND}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin dep || die "dobin failed"
	doman dep.1
	dodoc ChangeLog*
	dobashcompletion dep.completion dep
}

pkg_posinst() {
	bash-completion_pkg_postinst
}
