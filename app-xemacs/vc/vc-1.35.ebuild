# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc/vc-1.35.ebuild,v 1.2 2003/10/03 02:44:25 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for Free systems."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/ediff
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

