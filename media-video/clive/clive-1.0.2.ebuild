# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/clive/clive-1.0.2.ebuild,v 1.4 2008/12/02 22:42:34 ranger Exp $

# We inherit distutils to get the pkg_* functions for byte compiling python
inherit versionator distutils

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://clive.sourceforge.net/"
SRC_URI="http://dl.gna.org/clive/$(get_version_component_range 1-2 ${PV}).x/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.4
	>=dev-libs/newt-0.51
	>=dev-python/urlgrabber-3.1.0
	>=dev-python/feedparser-4.1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf $(use_with doc)
	emake || die "emake failed"
	if use doc; then
		emake dox || die "failed to create the documentation"
	fi
}

src_install() {
	emake py_compile=true DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README CHANGES
	use doc && dohtml dox/html/*
}
