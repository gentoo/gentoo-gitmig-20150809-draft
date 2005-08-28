# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/stripes/stripes-0.2.ebuild,v 1.7 2005/08/28 02:25:29 tester Exp $

inherit elisp

DESCRIPTION="Stripes is an Emacs mode which highlights every even line with an alternative background color."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/StripesMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc-macos x86"
IUSE=""

SITEFILE=50stripes-gentoo.el
