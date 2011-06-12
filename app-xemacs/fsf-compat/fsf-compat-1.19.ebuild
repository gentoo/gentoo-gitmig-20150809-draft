# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/fsf-compat/fsf-compat-1.19.ebuild,v 1.3 2011/06/12 04:11:16 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="FSF Emacs compatibility files."
PKG_CAT="standard"

KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 ~sparc x86"

inherit xemacs-packages

RDEPEND="app-xemacs/xemacs-base
"
