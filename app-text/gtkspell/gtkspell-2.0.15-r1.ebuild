# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.15-r1.ebuild,v 1.2 2010/01/02 11:20:58 fauli Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Spell checking widget for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
# gtkspell doesn't use sourceforge mirroring system it seems.
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2
	>=app-text/enchant-1.1.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0
	doc? ( >=dev-util/gtk-doc-1
		=app-text/docbook-xml-dtd-4.2* )"

src_prepare() {
	# Bug #270177
	epatch "${FILESDIR}"/${P}-fix-null-list.patch
}

src_configure() {
	econf $(use_enable doc gtk-doc)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
