# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sml-mode/sml-mode-0.07.ebuild,v 1.4 2004/04/01 01:55:11 jhuebel Exp $

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

