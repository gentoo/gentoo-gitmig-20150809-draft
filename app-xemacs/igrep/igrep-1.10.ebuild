# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/igrep/igrep-1.10.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Enhanced front-end for Grep."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/efs
"

inherit xemacs-packages

