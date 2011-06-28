# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/speedbar/speedbar-1.29.ebuild,v 1.4 2011/06/28 21:43:13 ranger Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Provides a separate frame with convenient references."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/edebug
app-xemacs/cedet-common
"
KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
