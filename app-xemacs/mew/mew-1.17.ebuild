# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mew/mew-1.17.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Messaging in an Emacs World."
PKG_CAT="standard"

DEPEND="app-xemacs/w3
app-xemacs/efs
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/fsf-compat
"

inherit xemacs-packages

