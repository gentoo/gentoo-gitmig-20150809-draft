# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/latin-unity/latin-unity-1.07.ebuild,v 1.10 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: find single ISO 8859 character set to encode a buffer."
PKG_CAT="mule"

DEPEND="app-xemacs/mule-base
app-xemacs/mule-ucs
app-xemacs/leim
app-xemacs/fsf-compat
app-xemacs/dired
"
KEYWORDS="x86 ~ppc alpha sparc amd64"

inherit xemacs-packages
