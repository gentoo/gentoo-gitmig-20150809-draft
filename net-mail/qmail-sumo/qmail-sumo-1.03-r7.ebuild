# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-sumo/qmail-sumo-1.03-r7.ebuild,v 1.4 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}
DESCRIPTION="Qmail - merge this package to merge all qmail packages"
HOMEPAGE="http://www.qmail.org/"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=net-mail/qmail-1.03-r6
	>=net-mail/qmail-pop3d-1.03-r1
	>=net-mail/fastforward-0.51
	>=net-mail/dot-forward-0.71
	>=net-mail/qmailanalog-0.70"

