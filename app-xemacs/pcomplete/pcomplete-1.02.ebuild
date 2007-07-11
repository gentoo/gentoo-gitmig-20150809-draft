# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcomplete/pcomplete-1.02.ebuild,v 1.11 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides programmatic completion."
PKG_CAT="standard"

DEPEND="app-xemacs/sh-script
app-xemacs/xemacs-base
"
KEYWORDS="x86 ppc alpha sparc amd64"

inherit xemacs-packages
