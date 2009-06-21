# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.8.ebuild,v 1.6 2009/06/21 18:27:20 ulm Exp $

inherit elisp

DESCRIPTION="Attach to an already running Emacs"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~app-emacs/gnuserv-programs-${PV} app-editors/xemacs )"

DOCS="ChangeLog README README.orig"
ELISP_PATCHES="${PN}-3.12.7-path-xemacs.patch"
SITEFILE="50${PN}-gentoo.el"
