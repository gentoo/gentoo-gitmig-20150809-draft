# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-pop3d/qmail-pop3d-1.03-r1.ebuild,v 1.11 2003/08/16 11:23:30 taviso Exp $

DESCRIPTION="Pop3 configuration for qmail which used the maildirs of the users"
HOMEPAGE="http://www.qmail.org"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha"

DEPEND=">=net-mail/qmail-1.03-r10"

pkg_setup() {
	einfo "This package has moved into the main qmail build as of -r10"
	einfo "re-emerge qmail to have the pop3 portion installed."
}
