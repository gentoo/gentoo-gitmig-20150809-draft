# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconf/pkgconf-9999.ebuild,v 1.2 2012/05/01 20:19:57 vapier Exp $

EAPI="4"

inherit autotools vcs-snapshot
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/nenolod/pkgconf.git"
	inherit git-2
else
	SRC_URI="https://github.com/nenolod/pkgconf/tarball/${P} -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

DESCRIPTION="pkg-config compatible replacement with no dependencies other than ANSI C89"
HOMEPAGE="https://github.com/nenolod/pkgconf"

LICENSE="BSD-1"
SLOT="0"
IUSE="pkg-config"

DEPEND=""
RDEPEND="${DEPEND}
	pkg-config? (
		!dev-util/pkgconfig
		!dev-util/pkg-config-lite
	)"

src_prepare() {
	AT_M4DIR="m4" eautoreconf
}

src_install() {
	default
	use pkg-config \
		&& dosym pkgconf /usr/bin/pkg-config \
		|| rm "${ED}"/usr/share/aclocal/pkg.m4 \
		|| die
}
