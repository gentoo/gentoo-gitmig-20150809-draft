# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rfcview/rfcview-0.5.ebuild,v 1.8 2005/09/09 16:06:43 agriffis Exp $

inherit elisp

DESCRIPTION="rfcview.el is a small Emacs add-on that reformats IETF RFCs for display"
HOMEPAGE="http://www.neilvandyke.org/rfcview/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc-macos x86"
IUSE=""

SITEFILE=50rfcview-gentoo.el
