# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/build/build-1.10.ebuild,v 1.5 2004/06/24 23:06:28 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Build XEmacs from within (UNIX, Windows)."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/pcl-cvs
app-xemacs/dired
app-xemacs/w3
app-xemacs/prog-modes
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
