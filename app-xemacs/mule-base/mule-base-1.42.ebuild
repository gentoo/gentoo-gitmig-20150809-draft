# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mule-base/mule-base-1.42.ebuild,v 1.5 2003/10/03 02:32:09 agriffis Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Basic Mule support, required for building with Mule."
PKG_CAT="mule"

DEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/apel
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

