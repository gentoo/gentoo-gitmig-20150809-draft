# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ocaml/ocaml-0.03.ebuild,v 1.6 2004/06/24 23:17:30 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Objective Caml editing support."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/fsf-compat
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

