# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/reftex/reftex-1.28.ebuild,v 1.5 2003/10/03 02:37:22 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs support for LaTeX cross-references, citations.."
PKG_CAT="standard"

DEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

