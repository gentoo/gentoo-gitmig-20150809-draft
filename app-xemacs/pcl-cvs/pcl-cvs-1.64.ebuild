# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pcl-cvs/pcl-cvs-1.64.ebuild,v 1.6 2004/02/21 22:45:51 brad_mssw Exp $

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
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

