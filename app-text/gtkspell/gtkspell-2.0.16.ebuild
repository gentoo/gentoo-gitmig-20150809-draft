# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.16.ebuild,v 1.12 2012/05/04 03:33:17 jdhore Exp $

EAPI=4

DESCRIPTION="Spell checking widget for GTK"
HOMEPAGE="http://gtkspell.sourceforge.net/"
# gtkspell doesn't use sourceforge mirroring system it seems.
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc"

RDEPEND="x11-libs/gtk+:2
	>=app-text/enchant-1.1.6"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35.0
	doc? ( dev-util/gtk-doc app-text/docbook-xml-dtd:4.2 )"

DOCS=( AUTHORS ChangeLog README ) # NEWS file is empty

src_prepare() {
	# Fix intltoolize broken file, see upstream #577133
	sed -i -e "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" po/Makefile.in.in || die
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable doc gtk-doc)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
