# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/jde/jde-1.38.ebuild,v 1.3 2003/02/13 09:54:27 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Java language and development support."
PKG_CAT="standard"

DEPEND="app-xemacs/cc-mode
app-xemacs/semantic
app-xemacs/debug
app-xemacs/speedbar
app-xemacs/edit-utils
app-xemacs/eterm
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/xemacs-devel
app-xemacs/eieio
app-xemacs/elib
app-xemacs/sh-script
app-xemacs/fsf-compat
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

