# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/efs/efs-1.29.ebuild,v 1.3 2003/02/13 09:52:10 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Treat files on remote systems the same as local files."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/dired
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

