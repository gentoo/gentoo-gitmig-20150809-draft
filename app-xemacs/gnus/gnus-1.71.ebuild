# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gnus/gnus-1.71.ebuild,v 1.2 2004/02/21 22:45:51 brad_mssw Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Gnus Newsreader and Mailreader."
PKG_CAT="standard"

DEPEND="app-xemacs/w3
app-xemacs/mh-e
app-xemacs/mailcrypt
app-xemacs/rmail
app-xemacs/eterm
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/ecrypto
app-xemacs/tm
app-xemacs/apel
>=app-xemacs/net-utils-1.32
"
KEYWORDS="amd64 ~x86 ~ppc ~alpha ~sparc"

inherit xemacs-packages

