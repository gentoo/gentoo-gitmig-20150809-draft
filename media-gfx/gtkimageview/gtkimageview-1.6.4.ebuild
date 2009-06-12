# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkimageview/gtkimageview-1.6.4.ebuild,v 1.5 2009/06/12 19:31:54 maekke Exp $

EAPI="2"

inherit autotools gnome2

DESCRIPTION="GtkImageView is a simple image viewer widget for GTK."
HOMEPAGE="http://trac.bjourne.webfactional.com/wiki"
SRC_URI="http://trac.bjourne.webfactional.com/attachment/wiki/WikiStart/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE="doc examples"
# tests do not work with userpriv
RESTRICT="userpriv"

RDEPEND="gnome-base/gnome-common
	>=x11-libs/gtk+-2.6"
DEPEND="${DEPEND}
	doc? ( >=dev-util/gtk-doc-1.8 )"

pkg_setup() {
	DOCS="README"
	# apparently docs are always built...
	use doc || export GTKDOC_REBASE=/bin/true
}

src_prepare() {
	sed -i -e '/CFLAGS/s/-Werror //g' configure.in || die
	gnome2_src_prepare
	eautoreconf
}

src_test() {
	# the tests are only built, but not run by default
	local failed="0"
	emake check || die
	cd "${S}"/tests
	for test in test-* ; do
		if [[ -x ${test} ]] ; then
			./${test} || failed=$((${failed}+1))
		fi
	done
	[[ ${failed} -gt 0 ]] && die "${failed} tests failed"
}

src_install() {
	gnome2_src_install
	if use examples ; then
		docinto examples
		dodoc tests/ex-*.c || die
	fi
}
