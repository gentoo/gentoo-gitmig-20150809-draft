# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/protbuf/protbuf-1.7.ebuild,v 1.8 2005/06/30 19:54:25 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Protect Emacs buffers from accidental killing."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ProtectingBuffers"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="virtual/emacs"

SITEFILE=50protbuf-gentoo.el
