# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.4-r1.ebuild,v 1.12 2004/08/07 21:32:24 slarti Exp $

inherit eutils

DESCRIPTION="Spell checking widget for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc alpha hppa amd64 ia64 mips"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2
	>=app-text/enchant-1"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	doc? ( >=dev-util/gtk-doc-0.6 )"

src_unpack() {

	unpack ${A}

	# fix the config script's gtkdoc check (bug #16997)
	cd ${S}
	sed -i "s:GTKDOC=true::" configure

	# workaround missing docbook 4.2 xml dtd in /etc/xml/docbook
	epatch ${FILESDIR}/${P}-docbookx.patch

	# use enchant as backend
	epatch ${FILESDIR}/${P}-enchant.patch

	autoconf || die

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
