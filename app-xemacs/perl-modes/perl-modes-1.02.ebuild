# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/perl-modes/perl-modes-1.02.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Perl support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/ispell
app-xemacs/ps-print
app-xemacs/edit-utils
app-xemacs/fsf-compat
"

inherit xemacs-packages

