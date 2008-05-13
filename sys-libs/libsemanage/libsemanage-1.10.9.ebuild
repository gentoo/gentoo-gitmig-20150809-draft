# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsemanage/libsemanage-1.10.9.ebuild,v 1.2 2008/05/13 02:34:55 pebenito Exp $

IUSE=""

inherit eutils multilib python

# BUGFIX_PATCH="${FILESDIR}/libsemanage-1.6.6.diff"

SEPOL_VER="1.16"
SELNX_VER="1.34"

DESCRIPTION="SELinux kernel and policy management library"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc sparc x86"
DEPEND="=sys-libs/libsepol-${SEPOL_VER}*
	=sys-libs/libselinux-${SELNX_VER}*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	[ ! -z "${BUGFIX_PATCH}" ] && epatch "${BUGFIX_PATCH}"

	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	python_version
	emake PYLIBVER="python${PYVER}" all pywrap || die
}

src_install() {
	python_version
	make DESTDIR="${D}" PYLIBVER="python${PYVER}" install install-pywrap

	# remove config file.  the appropriate
	# policy will install this file.
	rm -fR "${D}/etc"
}

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}usr/lib/python${PYVER}/site-packages"
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}usr/lib/python${PYVER}/site-packages"
}
