# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtkdiff/gtkdiff-1.8.0-r2.ebuild,v 1.10 2004/09/01 02:07:58 tgall Exp $

DESCRIPTION="GNOME Frontend for diff"
SRC_URI="http://home.catv.ne.jp/pp/ginoue/software/gtkdiff/${P}.tar.gz"
HOMEPAGE="http://home.catv.ne.jp/pp/ginoue/software/gtkdiff/index-e.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc ~amd64 ppc ppc64"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	sys-apps/diffutils"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext dev-util/intltool )"

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
