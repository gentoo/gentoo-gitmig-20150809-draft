# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/treeviewx/treeviewx-0.5.1.ebuild,v 1.3 2005/11/19 16:28:48 ribosome Exp $

inherit eutils

DESCRIPTION="A phylogenetic tree viewer"
HOMEPAGE="http://darwin.zoology.gla.ac.uk/~rpage/treeviewx/"
SRC_URI="http://darwin.zoology.gla.ac.uk/~rpage/${PN}/download/0.5/tv-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.6"

S="${WORKDIR}/tv-${PV}"

pkg_setup() {
	if ! built_with_use x11-libs/wxGTK X; then
		echo
		eerror "TreeViewX requires an SVG library which is part of the"
		eerror "optional X support in the \"x11-libs/wxGTK\" package. To"
		eerror "install TreeViewX on your system, first recompile"
		eerror "\"x11-libs/wxGTK\" with the \"X\" USE flag enabled, then try"
		eerror "to install TreeViewX again."
		die "X support not enabled in \"x11-libs/wxGTK\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-wxt.patch
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
