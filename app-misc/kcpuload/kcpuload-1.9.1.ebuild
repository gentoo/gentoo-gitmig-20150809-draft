# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.9.1.ebuild,v 1.5 2002/07/27 10:44:29 seemant Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A CPU applet for KDE3"
SRC_URI="http://ftp.kde.com/Administration/Monitoring/Resources/KCPULoad/${P}.tar.gz"
HOMEPAGE="http://ftp.kde.com/Administration/Monitoring/Resources/KCPULoad/"


LICENSE="GPL-2"
KEYWORDS="x86"
