# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sml-mode/sml-mode-0.07.ebuild,v 1.5 2004/06/24 23:21:42 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="SML editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/edebug
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

