# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-2.0.94.ebuild,v 1.3 2011/02/06 14:58:44 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit multilib python toolchain-funcs

SEPOL_VER="2.0.41"

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20100525/devel/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ruby"

DEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	dev-lang/swig
	ruby? ( dev-lang/ruby )"

RDEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	ruby? ( dev-lang/ruby )"

src_prepare() {
	# fix up paths for multilib
	sed -i -e "/^LIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib LIBDIR failed."
	sed -i -e "/^SHLIBDIR/s/lib/$(get_libdir)/" "${S}/src/Makefile" \
		|| die "Fix for multilib SHLIBDIR failed."
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)" LDFLAGS="-fPIC ${LDFLAGS}" all || die

	python_copy_sources src
	building() {
		emake CC="$(tc-getCC)" PYLIBVER="python$(python_get_version)" LDFLAGS="-fPIC ${LDFLAGS}" pywrap
	}
	python_execute_function -s --source-dir src building

	if use ruby; then
		emake CC="$(tc-getCC)" rubywrap || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	installation() {
		emake DESTDIR="${D}" PYLIBVER="python$(python_get_version)" install-pywrap
	}
	python_execute_function -s --source-dir src installation

	if use ruby; then
		emake DESTDIR="${D}" install-rubywrap || die
	fi
}

pkg_postinst() {
	python_mod_optimize selinux
}

pkg_postrm() {
	python_mod_cleanup selinux
}
