# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/stripes/stripes-0.2.ebuild,v 1.6 2005/01/01 14:02:06 eradicator Exp $

inherit elisp

DESCRIPTION="Stripes is an Emacs mode which highlights every even line with an alternative background color."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/StripesMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos"
IUSE=""

SITEFILE=50stripes-gentoo.el
