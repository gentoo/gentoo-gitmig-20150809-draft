# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcl-cvs/pcl-cvs-1.64.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

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

inherit xemacs-packages

