# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdr/libcdr-9999.ebuild,v 1.3 2012/02/27 21:42:16 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/libcdr/"
[[ ${PV} == 9999 ]] && vcs="autotools git-2"
inherit base ${vcs}
unset vcs

DESCRIPTION="Library parsing the Corel cdr documents"
HOMEPAGE="http://cgit.freedesktop.org/libreoffice/libcdr/tree/"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	media-libs/lcms:2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/libtool
	doc? ( app-doc/doxygen )
"

src_prepare() {
	base_src_prepare
	[[ -d m4 ]] || mkdir "m4"
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
