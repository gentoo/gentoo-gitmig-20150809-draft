# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.8.1.ebuild,v 1.1 2006/12/17 14:10:20 masterdriverz Exp $

inherit eutils

DESCRIPTION="free (Y)unicode text editor for all unices"
SRC_URI="http://yudit.org/download/${P}.tar.gz"
HOMEPAGE="http://www.yudit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="|| ( x11-libs/libX11 virtual/x11 )
	>=sys-devel/gettext-0.10"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e 's:bin/install-sh -c -s:bin/install-sh -c:' Makefile.conf.in || die 'sed failed'
}

src_compile() {
	econf || die 'econf failed'
	# Fails parallel make
	emake -j1 || die 'emake failed'
}

src_install() {
	emake DESTDIR=${D} install || die
	doicon icons/SS_Yudit_XPM.xpm
	make_desktop_entry ${PN} "Unicode Text Editor Yudit" SS_Yudit_XPM.xpm Utility
}
