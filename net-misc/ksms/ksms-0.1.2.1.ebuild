# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksms/ksms-0.1.2.1.ebuild,v 1.6 2004/07/03 21:22:42 carlo Exp $

inherit kde

S=${WORKDIR}/${P:0:10}

DESCRIPTION="an application for sending and archiving SMS messages using a GSM mobile phone"
SRC_URI="http://ftp.kde.com/Communications/Pagers_Messenging/KSms2/ksms_0.1.2-1.tar.gz"
HOMEPAGE="http://www.schuerig.de/michael/linux/ksms/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-misc/gsmlib"
need-kde 3

PATCHES="${FILESDIR}/${P}-empty-store.diff"



