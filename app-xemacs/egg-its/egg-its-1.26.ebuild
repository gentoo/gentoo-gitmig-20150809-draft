# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/egg-its/egg-its-1.26.ebuild,v 1.8 2004/06/24 23:10:52 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Wnn (4.2 and 6) support.  SJ3 support."
PKG_CAT="mule"

DEPEND="app-xemacs/leim
app-xemacs/mule-base
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
