# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gnus/gnus-1.65.ebuild,v 1.6 2005/01/01 17:05:45 eradicator Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Gnus Newsreader and Mailreader."
PKG_CAT="standard"

DEPEND="app-xemacs/w3
app-xemacs/mh-e
app-xemacs/mailcrypt
app-xemacs/rmail
app-xemacs/xemacs-eterm
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/ecrypto
app-xemacs/tm
app-xemacs/apel
"
KEYWORDS="x86 ~ppc alpha sparc"

inherit xemacs-packages

