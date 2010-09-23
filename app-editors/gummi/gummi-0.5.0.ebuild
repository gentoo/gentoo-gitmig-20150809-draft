# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gummi/gummi-0.5.0.ebuild,v 1.1 2010/09/23 21:27:30 hwoarang Exp $

EAPI=2
inherit base eutils

DESCRIPTION="Simple LaTeX editor for GTK+ users"
HOMEPAGE="http://gummi.midnightcoding.org"
SRC_URI="http://dev.midnightcoding.org/redmine/attachments/download/62/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="ca da de fr el it nl pt_BR ru zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND=">=dev-libs/glib-2.16:2
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexextra
	>=x11-libs/gtk+-2.16:2"
DEPEND="${RDEPEND}
	app-text/gtkspell
	app-text/poppler
	x11-libs/gtksourceview:2.0
	x11-libs/pango"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	# fix linguas
	cd "${S}"/po
	mv ca_ES.po ca.po || die
	mv gr_EL.po el.po || die
	mv it_IT.po it.po || die
	mv nl_NL.po nl.po || die
	strip-linguas ${LANGS}
}

pkg_postinst() {
	elog "Gummi >=0.4.8 supports spell-checking through gtkspell. Support for"
	elog "additional languages can be added by installing myspell-** packages"
	elog "for your language of choice."
}
