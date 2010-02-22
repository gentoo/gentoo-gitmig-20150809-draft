# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ketchup/ketchup-0.9.6-r1.ebuild,v 1.5 2010/02/22 18:46:49 phajdan.jr Exp $

inherit eutils

DESCRIPTION="Ketchup is a tool for updating or switching between versions of the Linux kernel source."
HOMEPAGE="http://www.selenic.com/ketchup/"
SRC_URI="http://www.selenic.com/ketchup/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="doc"

src_install() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}/ketchup-list.patch"
	dobin ./ketchup || die "could not install script"

	if use doc; then
		doman ketchup.1 || die "could not install ketchup manual"
	fi
}
