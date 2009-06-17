# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.13-r1.ebuild,v 1.3 2009/06/17 13:04:25 fauli Exp $

ARTS_REQUIRED="never"

inherit flag-o-matic kde eutils

DESCRIPTION="KCDLabel is a KDE program used to create covers, labels and booklets for your CD cases."
HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.5

S="${WORKDIR}/${P}-KDE3"

PATCHES=(
	"${FILESDIR}/kcdlabel-2.13-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack

	rm -f "${S}"/configure
}

src_compile(){
	append-flags -fpermissive
	kde_src_compile all
}

src_install(){
	kde_src_install
	insinto /usr/share/pixmaps
	doins "${S}"/kcdlabel/icons/kcdlabel.xpm
}
