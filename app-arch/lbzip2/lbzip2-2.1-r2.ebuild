# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lbzip2/lbzip2-2.1-r2.ebuild,v 1.1 2011/12/05 19:42:45 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="https://github.com/kjn/lbzip2/"
SRC_URI="mirror://github/kjn/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="symlink"

src_prepare() {
	cd src
	epatch \
		"${FILESDIR}"/0.23-s_isreg.patch \
		"${FILESDIR}"/${PV}-crc-missmatch.patch
}

src_install() {
	default

	if use symlink; then
		dosym ${PN} /usr/bin/bzip2
	fi
}
