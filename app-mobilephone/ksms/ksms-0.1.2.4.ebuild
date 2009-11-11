# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/ksms/ksms-0.1.2.4.ebuild,v 1.3 2009/11/11 02:10:31 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

S=${WORKDIR}/${P:0:10}

DESCRIPTION="an application for sending and archiving SMS messages using a GSM mobile phone"
HOMEPAGE="http://www.schuerig.de/michael/linux/ksms/index.html"
SRC_URI="http://www.schuerig.de/michael/debian/ksms_0.1.2-4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="app-mobilephone/gsmlib"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-empty-store.patch
	${FILESDIR}/${P}-gcc41.patch" )
