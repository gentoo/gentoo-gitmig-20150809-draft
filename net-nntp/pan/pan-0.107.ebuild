# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.107.ebuild,v 1.2 2006/08/09 18:47:28 swegener Exp $

inherit eutils

DESCRIPTION="A newsreader for the Gnome2 desktop"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="gnome spell"

RDEPEND=">=dev-libs/glib-2.4.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libpcre-5.0
	>=dev-libs/gmime-2.1.0
	spell? ( >=app-text/gtkspell-2.0.7 )
	gnome? ( >=gnome-base/libgnome-2.0 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/pan-0.14.2-update-desktop-file.patch
}

src_compile() {
	econf \
		$(use_with gnome) \
		$(use_with spell gtkspell) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
