# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.4-r1.ebuild,v 1.13 2004/11/04 22:54:47 vapier Exp $

inherit eutils

DESCRIPTION="Spell checking widget for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
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

	econf $(use_enable doc gtk-doc) || die
	emake || die "compile failure"

}

src_install() {

	einstall || die
	dodoc AUTHORS ChangeLog NEWS README

}
