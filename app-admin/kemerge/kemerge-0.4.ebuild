# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kemerge/kemerge-0.4.ebuild,v 1.8 2002/07/27 10:44:28 seemant Exp $

inherit kde-base || die

need-kde 3
DESCRIPTION="Graphical KDE emerge tool"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kemerge.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86"

newdepend ">=app-admin/kebuildpart-0.1
	>=app-admin/kebuild-0.1"
