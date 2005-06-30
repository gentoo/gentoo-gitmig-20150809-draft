# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.1.ebuild,v 1.2 2005/06/30 15:03:43 danarmak Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~ia64"
IUSE=""

DEPEND=""

myconf="--disable-kig-python-scripting"
