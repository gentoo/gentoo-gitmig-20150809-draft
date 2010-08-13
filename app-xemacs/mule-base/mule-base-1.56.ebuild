# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/mule-base/mule-base-1.56.ebuild,v 1.1 2010/08/13 09:07:55 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Basic Mule support, required for building with Mule."
PKG_CAT="mule"

RDEPEND="app-xemacs/fsf-compat
app-xemacs/xemacs-base
app-xemacs/apel
"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
