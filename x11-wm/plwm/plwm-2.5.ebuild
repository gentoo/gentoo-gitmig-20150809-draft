# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/plwm/plwm-2.5.ebuild,v 1.2 2003/05/07 20:44:51 mholzer Exp $

DESCRIPTION="Python classes for, and an implementation of, a window manager."

HOMEPAGE="http://plwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/plwm/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 alpha"
IUSE=""
DEPEND=">=dev-lang/python-2.2.2"
RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/python-xlib-0.12"

src_compile() {
	econf || die "econf failed for ${P}"
}

src_install() {
	# bulk of the package
	make \
		prefix="${D}/usr" \
		PLWM_PATH="${D}"'$(PYTHON_SITE_PATH)/plwm' \
		install \
    || die "make install failed for ${P}"

	# info page
	make -C doc || die "make info docs failed for ${P}"
	doinfo doc/*.info* || die "doinfo failed for ${P}"

	# other docs
	dodoc README NEWS ONEWS examples/* || die "dodoc failed for ${P}"
}
