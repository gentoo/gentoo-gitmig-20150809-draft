# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/texinfo/texinfo-1.30.ebuild,v 1.5 2007/09/20 16:08:32 jer Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XEmacs TeXinfo support."
PKG_CAT="standard"

RDEPEND="app-xemacs/text-modes
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"

inherit xemacs-packages
