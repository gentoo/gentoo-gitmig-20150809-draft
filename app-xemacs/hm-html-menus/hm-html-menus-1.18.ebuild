# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/hm-html-menus/hm-html-menus-1.18.ebuild,v 1.3 2003/02/13 09:53:52 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="HTML editing."
SRC_URI="http://ftp.xemacs.org/packages/hm--html-menus-1.18-pkg.tar.gz"
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

