# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mode-compile/mode-compile-2.29.ebuild,v 1.2 2007/05/16 06:08:17 opfer Exp $

inherit elisp

DESCRIPTION="Smart command for compiling files according to major-mode"
HOMEPAGE="http://perso.tls.cena.fr/boubaker/Emacs/"
# Taken from http://perso.tls.cena.fr/boubaker/distrib/${PN}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
