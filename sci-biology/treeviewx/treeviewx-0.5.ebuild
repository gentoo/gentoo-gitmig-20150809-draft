# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/treeviewx/treeviewx-0.5.ebuild,v 1.1 2005/03/30 22:17:58 ribosome Exp $

inherit eutils

DESCRIPTION="A phylogenetic tree viewer"
HOMEPAGE="http://darwin.zoology.gla.ac.uk/~rpage/treeviewx/"
SRC_URI="http://darwin.zoology.gla.ac.uk/~rpage/${PN}/download/${PV}/tv-${PV}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4.2-r2"

S=${WORKDIR}/tv-${PV}

pkg_setup() {
	if ! [ -e /usr/lib/libwx_gtk2-2.4.so ]; then
		eerror "TreeView X requires the non Unicode, gtk2-enabled version"
		eerror "of the wxGTK library. This version was not found on your"
		eerror "system. Please install \">=x11-libs/wx_TK-2.4.2-r2\" with"
		eerror "the \"gtk2\" \"USE\" flag enabled."
		die "Could not find non Unicode, gtk2-enabled wxGTK library."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc-3.4.patch
}

src_compile() {
	econf || die
	# The configure script may pick the Unicode wxGTK.
	if grep -q "gtk2u" Makefile; then
		sed -i -e 's/gtk2u/gtk2/' Makefile || die
		cd TreeLib
		sed -i -e 's/gtk2u/gtk2/' Makefile || die
		cd ../ncl-2.0
		sed -i -e 's/gtk2u/gtk2/' Makefile || die
		cd src
		sed -i -e 's/gtk2u/gtk2/' Makefile || die
	fi
	cd ${S}
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
