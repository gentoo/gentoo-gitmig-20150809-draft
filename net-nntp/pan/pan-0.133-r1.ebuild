# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.133-r1.ebuild,v 1.2 2010/12/17 23:10:37 eva Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="
	http://pan.rebelbase.com/download/releases/${PV}/source/${P}.tar.bz2
	http://dev.gentoo.org/~jer/${P}-gmime-2.4.patch
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.4:2
	>=x11-libs/gtk+-2.4:2
	>=dev-libs/libpcre-5
	dev-libs/gmime:2.4
	spell? ( >=app-text/gtkspell-2.0.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch "${DISTDIR}"/${P}-gmime-2.4.patch
}

src_configure() {
	econf $(use_with spell gtkspell)
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
