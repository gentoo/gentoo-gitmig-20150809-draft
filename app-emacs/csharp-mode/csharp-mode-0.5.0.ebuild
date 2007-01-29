# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/csharp-mode/csharp-mode-0.5.0.ebuild,v 1.2 2007/01/29 01:07:26 mr_bones_ Exp $

inherit elisp

IUSE=""

DESCRIPTION="A derived Emacs mode implementing most of the C# rules."
HOMEPAGE="http://mfgames.com/linux/csharp-mode"
SRC_URI="http://mfgames.com/linux/releases/csharp-mode-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

SITEFILE=80csharp-mode-gentoo.el

DEPEND="virtual/emacs
	|| ( app-editors/emacs-cvs app-emacs/cc-mode )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	mv ${S}/${P}.el ${S}/${PN}.el
}
