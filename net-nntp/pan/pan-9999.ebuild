# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-9999.ebuild,v 1.6 2011/09/21 08:42:43 mgorny Exp $

EAPI="3"

inherit autotools base git-2

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="http://pan.rebelbase.com/"

EGIT_REPO_URI="git://git.gnome.org/${PN}2
	http://git.gnome.org/browse/${PN}2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.16:2
	dev-libs/gmime:2.4
	spell? ( >=app-text/gtkspell-2.0.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	sys-devel/gettext"

# The normal version tree ebuild we are based on (for patching)
Pnorm="${PN}-0.134"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	# bootstrap build system
	intltoolize --force --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_with spell gtkspell)
}
