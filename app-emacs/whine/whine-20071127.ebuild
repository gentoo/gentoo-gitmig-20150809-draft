# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/whine/whine-20071127.ebuild,v 1.1 2007/12/21 14:50:24 ulm Exp $

inherit elisp

DESCRIPTION="Complaint generator for GNU Emacs"
HOMEPAGE="http://groups.google.com/group/comp.emacs/msg/00352d73fff71dca"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
