# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkimageview/gtkimageview-1.6.4.ebuild,v 1.23 2012/04/30 06:48:08 jlec Exp $

EAPI=4

VIRTUALX_REQUIRED=test

inherit autotools gnome2 virtualx

DESCRIPTION="A simple image viewer widget for GTK"
HOMEPAGE="http://trac.bjourne.webfactional.com/wiki/"
SRC_URI="http://trac.bjourne.webfactional.com/attachment/wiki/WikiStart/${P}.tar.gz?format=raw -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc examples static-libs"

# tests do not work with userpriv
RESTRICT="userpriv"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.8 )"

pkg_setup() {
	DOCS="README"
	G2CONF="$(use_enable static-libs static)"
}

src_prepare() {
	gnome2_src_prepare

	# Prevent excessive build failures due to gcc changes
	sed -e '/CFLAGS/s/-Werror //g' -i configure.in || die "sed 1 failed"

	# Prevent excessive build failures due to glib/gtk changes
	sed '/DEPRECATED_FLAGS/d' -i configure.in || die "sed 2 failed"

	# Gold linker fix
	sed -e '/libtest.la/s:$: -lm:g' -i tests/Makefile.am || die

	if use doc; then
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=/usr/bin/gtkdoc-rebase" \
			-i gtk-doc.make || die "sed 3 failed"
	else
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=true" \
			-i gtk-doc.make || die "sed 4 failed"
	fi

	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_test() {
	# the tests are only built, but not run by default
	local failed="0"
	Xemake check
	cd "${S}"/tests
	for test in ./test-* ; do
		if [[ -x ${test} ]] ; then
			VIRTUALX_COMMAND="${test}"
			virtualmake || failed=$((${failed}+1))
		fi
	done
	[[ ${failed} -gt 0 ]] && die "${failed} tests failed"
}

src_install() {
	gnome2_src_install
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/*.la
	if use examples ; then
		docinto examples
		dodoc tests/ex-*.c
	fi
}
