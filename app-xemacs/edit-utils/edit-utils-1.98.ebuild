# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edit-utils/edit-utils-1.98.ebuild,v 1.2 2003/10/03 02:21:53 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous editor extensions, you probably need this."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-devel
app-xemacs/fsf-compat
app-xemacs/dired
app-xemacs/mail-lib
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

