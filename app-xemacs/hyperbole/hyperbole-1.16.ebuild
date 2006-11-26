# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/hyperbole/hyperbole-1.16.ebuild,v 1.1 2006/11/26 08:12:44 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Hyperbole: The Everyday Info Manager."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
app-xemacs/mail-lib
app-xemacs/calendar
app-xemacs/vm
app-xemacs/text-modes
app-xemacs/gnus
app-xemacs/mh-e
app-xemacs/rmail
app-xemacs/apel
app-xemacs/tm
app-xemacs/sh-script
app-xemacs/net-utils
"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

inherit xemacs-packages

