# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ksms/ksms-0.1.2.1.ebuild,v 1.4 2004/06/24 23:52:58 agriffis Exp $

inherit kde

need-kde 3

LICENSE="GPL-2"
DESCRIPTION="an application for sending and archiving SMS messages using a GSM mobile phone"
SRC_URI="http://ftp.kde.com/Communications/Pagers_Messenging/KSms2/ksms_0.1.2-1.tar.gz"
HOMEPAGE="http://www.schuerig.de/michael/linux/ksms/index.html"
KEYWORDS="~x86"
DEPEND="net-misc/gsmlib"
S=${WORKDIR}/${P:0:10}
PATCHES="${FILESDIR}/${P}-empty-store.diff"

