# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.18.1-r1.ebuild,v 1.2 2005/08/04 03:41:11 leonardop Exp $

inherit eutils flag-o-matic gnome.org

MY_PN="pkg-config"
MY_P=${MY_PN}-${PV}
DESCRIPTION="Package config system that manages compile/link flags for libraries"
HOMEPAGE="http://pkgconfig.freedesktop.org/wiki/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="hardened"

# automake dependency is necessary (bug #99819)
DEPEND="=sys-devel/automake-1.7*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	use ppc64 && use hardened && replace-flags -O[2-3] -O1

	# Set the default search path correctly
	epatch ${FILESDIR}/${MY_P}-pc_path.patch
	# Fix compilation-time tests. See bug #98651.
	epatch ${FILESDIR}/${MY_P}-checks.patch

	export WANT_AUTOMAKE=1.7
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README
}
