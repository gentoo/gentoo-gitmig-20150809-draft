# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc/vc-1.33.ebuild,v 1.1 2002/12/16 12:22:48 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for Free systems."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/ediff
"

inherit xemacs-packages

