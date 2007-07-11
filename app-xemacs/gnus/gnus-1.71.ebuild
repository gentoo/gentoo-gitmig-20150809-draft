# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gnus/gnus-1.71.ebuild,v 1.11 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="The Gnus Newsreader and Mailreader."
PKG_CAT="standard"

RDEPEND="app-xemacs/w3
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
>=app-xemacs/net-utils-1.32
"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc ~x86"

inherit xemacs-packages
