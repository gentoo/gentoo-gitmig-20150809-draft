# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/os-utils/os-utils-1.30.ebuild,v 1.2 2003/10/03 02:33:00 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Miscellaneous O/S utilities."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

