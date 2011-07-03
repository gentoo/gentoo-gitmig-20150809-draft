# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/semantic/semantic-1.21.ebuild,v 1.8 2011/07/03 08:08:58 hwoarang Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Semantic bovinator (Yacc/Lex for XEmacs). Includes Senator."
PKG_CAT="standard"

RDEPEND="app-xemacs/ede
app-xemacs/cedet-common
app-xemacs/eieio
app-xemacs/xemacs-base
app-xemacs/xemacs-devel
app-xemacs/edit-utils
app-xemacs/speedbar
app-xemacs/texinfo
app-xemacs/fsf-compat
app-xemacs/cc-mode
app-xemacs/edebug
app-xemacs/sgml
"
KEYWORDS="alpha amd64 ppc sparc x86"

inherit xemacs-packages
