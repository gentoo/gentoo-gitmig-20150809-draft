# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ada/ada-1.13.ebuild,v 1.4 2004/03/31 23:40:11 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Ada language support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
