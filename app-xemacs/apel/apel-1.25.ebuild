# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/apel/apel-1.25.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Portable Emacs Library.  Used by XEmacs MIME support."
PKG_CAT="standard"

DEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
"

inherit xemacs-packages

