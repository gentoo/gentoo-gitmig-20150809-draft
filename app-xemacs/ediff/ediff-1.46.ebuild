# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ediff/ediff-1.46.ebuild,v 1.6 2004/08/10 02:35:49 tgall Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Interface over GNU patch."
PKG_CAT="standard"

DEPEND="app-xemacs/pcl-cvs
app-xemacs/elib
app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/edebug
app-xemacs/prog-modes
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages
