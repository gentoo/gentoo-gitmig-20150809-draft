# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/leim/leim-1.19.ebuild,v 1.6 2004/06/24 23:15:06 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Quail.  All non-English and non-Japanese language support."
PKG_CAT="mule"

DEPEND="app-xemacs/mule-base
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

