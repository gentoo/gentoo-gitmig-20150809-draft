# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ketchup/ketchup-0.9.6_p20060301.ebuild,v 1.2 2006/03/06 05:16:57 morfic Exp $

inherit eutils

DESCRIPTION="tool for updating or switching between versions of the Linux kernel source"
HOMEPAGE="http://www.selenic.com/ketchup/wiki/"

if [[ $PV == *_p* ]]; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
else
	SRC_URI="http://www.selenic.com/ketchup/${P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="doc"

S=${WORKDIR}

src_install() {
	cd Ketchup* 2>/dev/null	# nightly snapshots unpack into a directory
	epatch "${FILESDIR}/ketchup-list.patch"

	dobin ./ketchup || die "could not install script"

	if use doc; then
		doman ketchup.1 || die "could not install ketchup manual"
	fi
}
