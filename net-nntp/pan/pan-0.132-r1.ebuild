# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.132-r1.ebuild,v 1.5 2008/01/25 21:38:21 philantrop Exp $

inherit eutils

DESCRIPTION="A newsreader for the Gnome2 desktop"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.4.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libpcre-5.0
	>=dev-libs/gmime-2.1.9
	spell? ( >=app-text/gtkspell-2.0.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/load-pixbuf-in-1024-byte-chunks.diff
}

src_compile() {
	econf $(use_with spell gtkspell) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
