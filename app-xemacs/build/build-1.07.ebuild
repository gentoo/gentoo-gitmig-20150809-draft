# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/build/build-1.07.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Build XEmacs from within (UNIX, Windows)."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/pcl-cvs
app-xemacs/dired
app-xemacs/w3
app-xemacs/prog-modes
"

inherit xemacs-packages

