# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/udept/udept-0.5.96.2.ebuild,v 1.2 2006/08/12 08:18:06 fuzzyray Exp $

inherit bash-completion eutils

DESCRIPTION="A Portage analysis toolkit"
HOMEPAGE="http://catmur.co.uk/gentoo/udept"
SRC_URI="http://files.catmur.co.uk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-shells/bash
	sys-apps/portage"
RDEPEND="${DEPEND}"

BASH_COMPLETION_NAME="dep"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/bash-completion-install.diff"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog*
}
