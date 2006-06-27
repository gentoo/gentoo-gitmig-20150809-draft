# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.62.ebuild,v 1.25 2006/06/27 20:45:13 kanaka Exp $

inherit eutils flag-o-matic

DESCRIPTION="Password database"
HOMEPAGE="http://packages.gentoo.org/ebuilds/?pwdb-${PVR}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="selinux"
RESTRICT="test" #122603

DEPEND="selinux? ( sys-libs/libselinux )"

src_unpack () {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch

	use selinux && epatch "${FILESDIR}"/${P}-selinux.patch

	sed -i \
		-e "s/^DIRS = .*/DIRS = libpwdb/" \
		-e "s:EXTRAS += :EXTRAS += ${CFLAGS} :" \
		Makefile || die "sed of Makefile failed"
	sed -i -e "s:=gcc:=$(tc-getCC):g" default.defs \
		|| die "sed of default.defs failed"
}

src_compile() {
	filter-flags -fstack-protector

	# author has specified application to be compiled with `-g` 
	# no problem, but with ccc `-g` disables optimisation to make
	# debugging easier, `-g3` enables debugging and optimisation
	[ "${ARCH}" = "alpha" -a "${CC}" = "ccc" ] && append-flags -g3

	emake || die
}

src_install() {
	dodir /$(get_libdir) /usr/$(get_libdir) /usr/include/pwdb
	make \
		INCLUDED="${D}"/usr/include/pwdb \
		LIBDIR="${D}"/$(get_libdir) \
		LDCONFIG="echo" \
		install || die

	mv "${D}"/$(get_libdir)/*.a "${D}"/usr/$(get_libdir)/ || die
	gen_usr_ldscript libpwdb.so

	insinto /etc
	doins conf/pwdb.conf

	dodoc CHANGES CREDITS README
	dohtml -r doc
	docinto txt
	dodoc doc/*.txt
}
