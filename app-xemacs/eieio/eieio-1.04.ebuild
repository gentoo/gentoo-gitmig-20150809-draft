# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/eieio/eieio-1.04.ebuild,v 1.6 2005/01/01 17:02:44 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Enhanced Implementation of Emacs Interpreted Objects"
PKG_CAT="standard"

DEPEND="app-xemacs/speedbar
app-xemacs/xemacs-base
app-xemacs/edebug
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
