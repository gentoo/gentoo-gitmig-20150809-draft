# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kcpuload/kcpuload-1.90-r2.ebuild,v 1.4 2002/05/21 18:14:06 danarmak Exp $

inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="A CPU applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${P}.tar.gz"
HOMEPAGE="http://kde.quakenet.eu.org/kcpuload.shtml"

