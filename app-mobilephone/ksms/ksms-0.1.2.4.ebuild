# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/ksms/ksms-0.1.2.4.ebuild,v 1.2 2006/02/26 09:25:28 mrness Exp $

inherit kde

S=${WORKDIR}/${P:0:10}

DESCRIPTION="an application for sending and archiving SMS messages using a GSM mobile phone"
HOMEPAGE="http://www.schuerig.de/michael/linux/ksms/index.html"
SRC_URI="http://www.schuerig.de/michael/debian/ksms_0.1.2-4.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="app-mobilephone/gsmlib"
need-kde 3

PATCHES="${FILESDIR}/${P}-empty-store.patch
	${FILESDIR}/${P}-gcc41.patch"
