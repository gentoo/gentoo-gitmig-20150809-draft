# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/sml-mode/sml-mode-5.0_beta1.ebuild,v 1.1 2012/06/02 11:18:16 ulm Exp $

EAPI=4

inherit elisp

MY_P=${P/_/}
DESCRIPTION="Emacs major mode for editing Standard ML"
HOMEPAGE="http://www.iro.umontreal.ca/~monnier/elisp/"
SRC_URI="http://www.iro.umontreal.ca/~monnier/elisp/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="test"

S="${WORKDIR}/${MY_P}"
SITEFILE="50${PN}-gentoo.el"
ELISP_TEXINFO="${PN}.texi"
DOCS="BUGS ChangeLog NEWS README TODO"

src_compile() {
	default
}
