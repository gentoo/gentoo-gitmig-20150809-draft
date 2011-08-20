# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvisio/libvisio-0.0.5.ebuild,v 1.1 2011/08/20 14:25:04 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/contrib/libvisio/"
[[ ${PV} == 9999 ]] && vcs="autotools git-2"
inherit base ${vcs}
unset vcs

DESCRIPTION="Library parsing the visio documents"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/libvisio"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	app-text/libwpd:0.9
	app-text/libwpg:0.2
"
DEPEND="${DEPEND}
	sys-devel/libtool
	doc? ( app-doc/doxygen )
"

src_prepare() {
	base_src_prepare
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-werror \
		$(use_with doc docs)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
