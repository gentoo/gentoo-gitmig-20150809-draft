# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsemanage/libsemanage-2.0.27.ebuild,v 1.6 2011/05/28 06:00:57 blueness Exp $

IUSE=""

inherit eutils multilib python

# BUGFIX_PATCH="${FILESDIR}/libsemanage-1.6.6.diff"

SEPOL_VER="2.0"
SELNX_VER="2.0"

DESCRIPTION="SELinux kernel and policy management library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/current/devel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="=sys-libs/libsepol-${SEPOL_VER}*
	=sys-libs/libselinux-${SELNX_VER}*
	dev-libs/ustr"
RDEPEND="${DEPEND}"

# tests are not meant to be run outside of the
# full SELinux userland repo
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	[ ! -z "${BUGFIX_PATCH}" ] && epatch "${BUGFIX_PATCH}"

	echo "# Set this to true to save the linked policy." >> "${S}/src/semanage.conf"
	echo "# This is normally only useful for analysis" >> "${S}/src/semanage.conf"
	echo "# or debugging of policy." >> "${S}/src/semanage.conf"
	echo "save-linked=false" >> "${S}/src/semanage.conf"
	echo >> "${S}/src/semanage.conf"
	echo "# Set this to 0 to disable assertion checking." >> "${S}/src/semanage.conf"
	echo "# This should speed up building the kernel policy" >> "${S}/src/semanage.conf"
	echo "# from policy modules, but may leave you open to" >> "${S}/src/semanage.conf"
	echo "# dangerous rules which assertion checking" >> "${S}/src/semanage.conf"
	echo "# would catch." >> "${S}/src/semanage.conf"
	echo "expand-check=1" >> "${S}/src/semanage.conf"

	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	emake PYLIBVER="python$(python_get_version)" all || die
	emake PYLIBVER="python$(python_get_version)" pywrap || die
}

src_install() {
	python_need_rebuild
	make DESTDIR="${D}" PYLIBVER="python$(python_get_version)" install install-pywrap
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/semanage.py
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/semanage.py
}
