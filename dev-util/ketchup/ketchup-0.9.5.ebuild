# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ketchup/ketchup-0.9.5.ebuild,v 1.1 2005/11/02 01:42:08 morfic Exp $


DESCRIPTION="Ketchup is a tool for updating or switching between versions of the Linux kernel source."
HOMEPAGE="http://www.selenic.com/ketchup/wiki/"
SRC_URI="http://www.selenic.com/ketchup/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc"

src_install() {
	cd "${WORKDIR}"
	dosbin ./ketchup || die "could not install script"

	if use doc; then
		doman ketchup.1 || die "could not install ketchup manual"
	fi
}
