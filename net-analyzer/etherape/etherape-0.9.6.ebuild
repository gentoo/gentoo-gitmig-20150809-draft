# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.6.ebuild,v 1.1 2006/09/04 16:41:30 pva Exp $

inherit eutils gnome2

DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	net-libs/libpcap
	sys-devel/gettext"

DOCS="ABOUT-NLS AUTHORS ChangeLog FAQ NEWS OVERVIEW README* TODO"

src_unpack() {
	unpack ${A};

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.9.3-res_mkquery.patch

	aclocal -I m4 || die "aclocal failed"
	autoconf || die "autoconf failed"
	libtoolize --copy --force
}
