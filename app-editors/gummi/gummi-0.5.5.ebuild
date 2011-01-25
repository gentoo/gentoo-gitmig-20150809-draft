# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gummi/gummi-0.5.5.ebuild,v 1.3 2011/01/25 12:49:20 fauli Exp $

EAPI=2
inherit base eutils

DESCRIPTION="Simple LaTeX editor for GTK+ users"
HOMEPAGE="http://gummi.midnightcoding.org"
SRC_URI="http://dev.midnightcoding.org/redmine/attachments/download/111/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

LANGS="ca da de fr el es it nl pl pt_BR ro ru zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="app-text/gtkspell
	>=dev-libs/glib-2.16:2
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexextra
	>=x11-libs/gtk+-2.16:2
	x11-libs/gtksourceview"
DEPEND="${RDEPEND}
	app-text/poppler[cairo]
	x11-libs/gtksourceview:2.0
	x11-libs/pango"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	strip-linguas ${LANGS}
}

pkg_postinst() {
	elog "Gummi >=0.4.8 supports spell-checking through gtkspell. Support for"
	elog "additional languages can be added by installing myspell-** packages"
	elog "for your language of choice."
}
