# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/hm-html-menus/hm-html-menus-1.18.ebuild,v 1.11 2005/01/01 17:06:11 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="HTML editing."
SRC_URI="http://ftp.xemacs.org/packages/hm--html-menus-${PV}-pkg.tar.gz"
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc amd64 ppc64"

inherit xemacs-packages

