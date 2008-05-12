# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-1.28-r1.ebuild,v 1.3 2008/05/12 00:44:44 pebenito Exp $

IUSE=""

SEPOL_VER="1.10"

inherit eutils multilib python

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc sparc x86"

DEPEND="=sys-libs/libsepol-${SEPOL_VER}*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	python_version
	emake PYLIBVER="python${PYVER}" LDFLAGS="-fPIC ${LDFLAGS}" || die

	# add compatability aliases to swig wrapper
	cat "${FILESDIR}/compat.py" >> "${S}/src/selinux.py" || die
}

src_install() {
	python_version
	make DESTDIR="${D}" PYLIBVER="python${PYVER}" install
}
