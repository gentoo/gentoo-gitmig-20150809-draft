# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/supercite/supercite-1.19.ebuild,v 1.11 2005/08/07 13:15:17 hansmi Exp $

SLOT="0"
IUSE=""
DESCRIPTION="An Emacs citation tool for News & Mail messages."
PKG_CAT="standard"

DEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages

