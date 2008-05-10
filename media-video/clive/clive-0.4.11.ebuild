# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/clive/clive-0.4.11.ebuild,v 1.2 2008/05/10 17:22:25 nixnut Exp $

# We inherit distutils to get the pkg_* functions for byte compiling python
inherit versionator distutils

DESCRIPTION="Command line tool for extracting videos from Youtube, Google Video, Dailymotion, Guba (free) and Stage6 websites"
HOMEPAGE="http://home.gna.org/clive/"
SRC_URI="http://dl.gna.org/clive/$(get_version_component_range 1-2 ${PV})/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.4
	>=dev-libs/newt-0.51
	>=dev-python/feedparser-4.1"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	# with-newt or --with-feedparser means compile its own
	econf $(use_with doc) --without-newt --without-feedparser
	emake || die "emake failed"
	if use doc; then
		emake dox || die "failed to create the documentation"
	fi
}

src_install() {
	emake py_compile=true DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README
	use doc && dohtml dox/html/*
}
