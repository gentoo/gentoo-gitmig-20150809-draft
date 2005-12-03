# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/fsf-compat/fsf-compat-1.12.ebuild,v 1.10 2005/12/03 20:16:06 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="FSF Emacs compatibility files."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ppc64 sparc x86"

inherit xemacs-packages
