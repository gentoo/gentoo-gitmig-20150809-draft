# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmenuedit/kmenuedit-4.0.2.ebuild,v 1.1 2008/03/10 23:43:46 philantrop Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

KMEXTRACTONLY="menu"
