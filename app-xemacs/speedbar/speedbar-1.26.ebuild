# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/speedbar/speedbar-1.26.ebuild,v 1.5 2004/06/24 23:22:14 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides a separate frame with convenient references."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/edebug
"
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

