# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xslt-process/xslt-process-1.11.ebuild,v 1.7 2004/04/01 02:14:15 jhuebel Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XSLT processing support."
PKG_CAT="standard"

DEPEND="app-xemacs/jde
app-xemacs/cc-mode
app-xemacs/semantic
app-xemacs/debug
app-xemacs/speedbar
app-xemacs/edit-utils
app-xemacs/eterm
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/elib
app-xemacs/eieio
app-xemacs/sh-script
app-xemacs/fsf-compat
app-xemacs/xemacs-devel
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages

