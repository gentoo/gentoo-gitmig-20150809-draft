# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/c-support/c-support-1.16.ebuild,v 1.3 2003/02/13 09:50:43 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Basic single-file add-ons for editing C code."
PKG_CAT="standard"

DEPEND="app-xemacs/cc-mode
app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

