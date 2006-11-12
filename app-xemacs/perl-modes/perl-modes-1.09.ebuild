# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/perl-modes/perl-modes-1.09.ebuild,v 1.1 2006/11/12 11:25:25 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Perl support."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/xemacs-ispell
app-xemacs/ps-print
app-xemacs/edit-utils
app-xemacs/fsf-compat
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

