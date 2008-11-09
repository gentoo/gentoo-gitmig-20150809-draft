# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrite/kwrite-4.1.3.ebuild,v 1.1 2008/11/09 02:51:54 scarabeus Exp $

EAPI="2"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="KDE MDI editor/ide"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

KMEXTRA="apps/doc/${PN}"
