# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/speedbar/speedbar-1.26.ebuild,v 1.3 2004/02/21 22:45:51 brad_mssw Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides a separate frame with convenient references."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/edebug
"
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

