# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtkimageview/gtkimageview-1.6.4.ebuild,v 1.1 2009/06/01 13:25:25 maekke Exp $

EAPI="2"

DESCRIPTION="GtkImageView is a simple image viewer widget for GTK."
HOMEPAGE="http://trac.bjourne.webfactional.com/wiki"
SRC_URI="http://trac.bjourne.webfactional.com/attachment/wiki/WikiStart/${P}.tar.gz?format=raw
-> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# tests do not work with userpriv
RESTRICT="userpriv"

DEPEND="gnome-base/gnome-common
	>=x11-libs/gtk+-2.6"
RDEPEND="${DEPEND}"

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
	emake DESTDIR="${D}" install || die
	dodoc README || die
}

