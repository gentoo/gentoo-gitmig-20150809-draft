# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/hm-html-menus/hm-html-menus-1.18.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="HTML editing."
SRC_URI="http://ftp.xemacs.org/packages/hm--html-menus-1.18-pkg.tar.gz"
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"

inherit xemacs-packages

