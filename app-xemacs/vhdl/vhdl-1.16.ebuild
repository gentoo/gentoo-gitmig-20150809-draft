# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vhdl/vhdl-1.16.ebuild,v 1.7 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Support for VHDL."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/edit-utils
app-xemacs/c-support
app-xemacs/speedbar
app-xemacs/ps-print
app-xemacs/os-utils
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
