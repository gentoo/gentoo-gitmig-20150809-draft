# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-9999.ebuild,v 1.3 2010/09/21 20:29:22 eva Exp $

EAPI="3"

inherit autotools base git

DESCRIPTION="A newsreader for the Gnome2 desktop"
HOMEPAGE="http://pan.rebelbase.com/"

EGIT_REPO_URI="git://git.gnome.org/${PN}2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/gmime-2.1.9:0
	spell? ( >=app-text/gtkspell-2.0.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	sys-devel/gettext"

# The normal version tree ebuild we are based on (for patching)
Pnorm="${PN}-0.133"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	git_src_prepare

	# bootstrap build system
	intltoolize --force --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_with spell gtkspell)
}

