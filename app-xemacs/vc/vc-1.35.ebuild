# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/vc/vc-1.35.ebuild,v 1.6 2004/08/10 02:34:20 tgall Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Version Control for Free systems."
PKG_CAT="standard"

DEPEND="app-xemacs/dired
app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/ediff
"
KEYWORDS="amd64 x86 ~ppc alpha sparc ppc64"

inherit xemacs-packages

