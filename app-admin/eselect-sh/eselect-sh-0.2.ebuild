# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-sh/eselect-sh-0.2.ebuild,v 1.1 2011/12/15 19:07:40 mgorny Exp $

EAPI=4

MY_P="sh.eselect-${PV}"
DESCRIPTION="Manages the /bin/sh (POSIX shell) symlink"
HOMEPAGE="https://github.com/mgorny/eselect-sh/"
SRC_URI="mirror://github/mgorny/${PN}/${MY_P}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/eselect/modules
	newins "${MY_P}" sh.eselect || die "newins failed"
}
