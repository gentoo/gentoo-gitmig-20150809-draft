# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/fsf-compat/fsf-compat-1.11.ebuild,v 1.7 2004/07/27 22:35:23 rac Exp $

SLOT="0"
IUSE=""
DESCRIPTION="FSF Emacs compatibility files."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ppc ~alpha sparc"

inherit xemacs-packages
