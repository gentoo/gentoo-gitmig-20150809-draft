# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.6.1.ebuild,v 1.2 2002/07/17 20:43:16 drobbins Exp $
inherit kde-base || die

need-kde 3

DESCRIPTION="ktail monitors multiple files and/or command output in one window."
LICENSE="GPL-2"
SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.bz2"
SLOT="0"

