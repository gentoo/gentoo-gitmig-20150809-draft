# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/shinonome/shinonome-0.9.11.ebuild,v 1.3 2005/02/12 14:32:51 nigoro Exp $

inherit font

IUSE=""

DESCRIPTION="Japanese bitmap fonts for X"
SRC_URI="http://openlab.jp/efont/dist/shinonome/${P}.tar.bz2"
HOMEPAGE="http://openlab.jp/efont/shinonome/"

LICENSE="public-domain"
SLOT=0
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64 ppc64"

DEPEND="virtual/libc
	virtual/x11
	dev-lang/perl
	sys-apps/gawk"
RDEPEND=""

FONT_SUFFIX="pcf.gz"
FONT_S=${S}
DOCS="AUTHORS BUGS ChangeLog* DESIGN* INSTALL LICENSE README THANKS TODO"

src_compile(){
	econf --with-pcf --without-bdf || die
	emake || die

	for i in *.pcf ; do
		gzip -9 $i
	done
}
