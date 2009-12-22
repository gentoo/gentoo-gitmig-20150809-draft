# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/whine/whine-20091222.ebuild,v 1.1 2009/12/22 15:45:49 ulm Exp $

inherit elisp

DESCRIPTION="Complaint generator for GNU Emacs"
HOMEPAGE="http://www.emacswiki.org/emacs/Whine"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
