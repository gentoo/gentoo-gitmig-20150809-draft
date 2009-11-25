# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.90.0.ebuild,v 1.1 2009/11/25 20:58:35 truedfx Exp $

inherit eutils multilib

DESCRIPTION="A GTK+/libglade/GNOME language binding for the librep Lisp environment"
HOMEPAGE="http://rep-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/rep-gtk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="gtk-2.0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/librep-0.17.3
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.18.4-locale.patch
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog HACKING README* TODO
}
