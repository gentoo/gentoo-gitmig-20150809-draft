# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksms/ksms-0.1.2.4.ebuild,v 1.1 2004/07/03 16:22:47 centic Exp $

inherit kde

need-kde 3

LICENSE="GPL-2"
DESCRIPTION="an application for sending and archiving SMS messages using a GSM mobile phone"
SRC_URI="http://www.schuerig.de/michael/debian/ksms_0.1.2-4.tar.gz"
HOMEPAGE="http://www.schuerig.de/michael/linux/ksms/index.html"
KEYWORDS="~x86"
DEPEND="net-misc/gsmlib"
S=${WORKDIR}/${P:0:10}
PATCHES="${FILESDIR}/${P}-empty-store.diff"
IUSE=""
SLOT="0"

