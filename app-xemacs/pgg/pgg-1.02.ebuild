# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/pgg/pgg-1.02.ebuild,v 1.2 2003/10/03 02:34:22 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs interface to various PGP implementations."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/edebug
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

