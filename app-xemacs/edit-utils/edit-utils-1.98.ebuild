# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/edit-utils/edit-utils-1.98.ebuild,v 1.3 2004/02/21 22:45:51 brad_mssw Exp $

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
KEYWORDS="amd64 x86 ~ppc alpha sparc"

inherit xemacs-packages

