# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/perl-modes/perl-modes-1.04.ebuild,v 1.4 2004/03/15 21:25:06 rac Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Perl support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/ps-print
app-xemacs/edit-utils
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

