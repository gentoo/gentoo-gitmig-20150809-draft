# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.4.ebuild,v 1.3 2003/03/08 22:05:57 foser Exp $

DESCRIPTION="spell library for GTK2"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"
IUSE="doc"

DEPEND=">=x11-libs/gtk+-2
	>=app-text/aspell-0.50
	doc? ( >=dev-util/gtk-doc-0.6 )"

src_unpack() {
	unpack ${A}

	# fix the config script's gtkdoc check (bug #16997)
	cd ${S}
	mv configure configure.old
	sed -e "s:GTKDOC=true::" configure.old > configure
	chmod +x configure
}

src_compile() {
	local myconf

	use doc \
		&& myconf="--enable-gtk-doc" \
		|| myconf="--disable-gtk-doc"
	
	econf ${myconf} || die
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
