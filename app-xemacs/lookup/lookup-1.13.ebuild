# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/lookup/lookup-1.13.ebuild,v 1.6 2004/03/13 00:15:36 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Dictionary support"
PKG_CAT="mule"

DEPEND="app-xemacs/mule-base
app-xemacs/cookie
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

