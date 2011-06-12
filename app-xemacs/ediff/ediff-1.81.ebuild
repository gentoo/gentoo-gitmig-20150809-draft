# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ediff/ediff-1.81.ebuild,v 1.2 2011/06/12 04:04:54 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Interface over GNU patch."
PKG_CAT="standard"

RDEPEND="app-xemacs/pcl-cvs
app-xemacs/elib
app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/edebug
app-xemacs/prog-modes
app-xemacs/gnus
app-xemacs/tramp
app-xemacs/vc
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages
