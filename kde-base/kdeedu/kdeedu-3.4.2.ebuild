# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.2.ebuild,v 1.2 2005/07/30 14:10:00 danarmak Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

myconf="--disable-kig-python-scripting"
