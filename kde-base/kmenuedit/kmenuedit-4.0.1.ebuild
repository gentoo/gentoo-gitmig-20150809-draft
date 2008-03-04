# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmenuedit/kmenuedit-4.0.1.ebuild,v 1.2 2008/03/04 02:59:38 jer Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"

KMEXTRACTONLY="menu"
