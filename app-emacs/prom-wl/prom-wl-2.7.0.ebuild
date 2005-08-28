# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prom-wl/prom-wl-2.7.0.ebuild,v 1.3 2005/08/28 02:20:50 tester Exp $

inherit elisp

IUSE=""

DESCRIPTION="Procmail reader for Wanderlust"
HOMEPAGE="http://www.h6.dion.ne.jp/~nytheta/software/prom-wl.html"
SRC_URI="http://www.h6.dion.ne.jp/~nytheta/software/pub/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc-macos ~x86"

RDEPEND="|| ( app-emacs/wanderlust app-emacs/wanderlust-cvs )"

SITEFILE="70prom-wl-gentoo.el"
