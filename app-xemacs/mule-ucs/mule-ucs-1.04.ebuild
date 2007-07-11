# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mule-ucs/mule-ucs-1.04.ebuild,v 1.10 2007/07/11 02:37:38 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Extended coding systems (including Unicode) for XEmacs."
PKG_CAT="mule"

DEPEND="app-xemacs/mule-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
