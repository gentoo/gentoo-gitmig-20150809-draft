# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vhdl/vhdl-1.15.ebuild,v 1.3 2003/02/13 09:59:52 vapier Exp $

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
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

