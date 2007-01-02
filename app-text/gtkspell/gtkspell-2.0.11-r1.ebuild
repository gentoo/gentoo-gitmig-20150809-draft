# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.11-r1.ebuild,v 1.5 2007/01/02 01:16:33 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit libtool eutils autotools

DESCRIPTION="Spell checking widget for GTK2"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2
	>=app-text/enchant-1.1.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1
		=app-text/docbook-xml-dtd-4.2* )"

src_unpack() {

	unpack ${A}

	cd "${S}"

	# use enchant as backend
	epatch "${FILESDIR}/${PN}-2.0.11-enchant.patch"
	# build on systems without nls (#134467)
	epatch "${FILESDIR}/${PN}-2.0.11-nonls.patch"

	eautoreconf
	elibtoolize
}

src_compile() {

	econf $(use_enable doc gtk-doc) || die
	emake || die "compile failure"

}

src_install() {

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README

}
