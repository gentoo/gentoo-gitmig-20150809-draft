# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/egg-its/egg-its-1.26.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Wnn (4.2 and 6) support.  SJ3 support."
PKG_CAT="mule"

DEPEND="app-xemacs/leim
app-xemacs/mule-base
app-xemacs/fsf-compat
app-xemacs/xemacs-base
"

inherit xemacs-packages

