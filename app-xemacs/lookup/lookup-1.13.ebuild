# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/lookup/lookup-1.13.ebuild,v 1.1 2002/12/16 12:22:47 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Dictionary support"
PKG_CAT="mule"

DEPEND="app-xemacs/mule-base
app-xemacs/cookie
"

inherit xemacs-packages

