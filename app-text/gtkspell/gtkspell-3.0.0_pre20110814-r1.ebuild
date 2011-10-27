# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-3.0.0_pre20110814-r1.ebuild,v 1.1 2011/10/27 07:02:37 tetromino Exp $

EAPI="4"

DESCRIPTION="Spell checking widget for GTK"
HOMEPAGE="http://gtkspell.sourceforge.net/"
# gtkspell doesn't use sourceforge mirroring system it seems.
#SRC_URI="http://${PN}.sourceforge.net/download/${PN}-2.0.16.tar.gz"
# Prerelease snapshot
SRC_URI="mirrors://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc"

RDEPEND=">=app-text/enchant-1.1.6
	x11-libs/gtk+:3
	>=x11-libs/pango-1.8.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.0

	doc? ( >=dev-util/gtk-doc-1.17 app-text/docbook-xml-dtd:4.2 )"

DOCS=( AUTHORS ChangeLog README ) # NEWS file is empty

src_configure() {
	econf \
		--disable-static \
		$(use_enable doc gtk-doc)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
