# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcl-cvs/pcl-cvs-1.64.ebuild,v 1.4 2003/02/22 12:46:40 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="CVS frontend."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/elib
app-xemacs/vc
app-xemacs/dired
app-xemacs/edebug
app-xemacs/ediff
app-xemacs/edit-utils
app-xemacs/mail-lib
app-xemacs/prog-modes
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

