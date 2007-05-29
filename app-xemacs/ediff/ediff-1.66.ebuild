# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ediff/ediff-1.66.ebuild,v 1.2 2007/05/29 18:28:46 armin76 Exp $

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
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
