# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/cogre/cogre-1.02.ebuild,v 1.4 2011/06/12 03:59:57 tomka Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Graph editing mode."
PKG_CAT="standard"

RDEPEND="
app-xemacs/xemacs-base
app-xemacs/xemacs-devel
app-xemacs/edebug
app-xemacs/cedet-common
app-xemacs/eieio
app-xemacs/semantic
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"

inherit xemacs-packages
