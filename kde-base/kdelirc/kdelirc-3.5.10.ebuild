# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelirc/kdelirc-3.5.10.ebuild,v 1.3 2009/06/06 11:18:13 maekke Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDElirc - KDE Frontend to lirc"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
	app-misc/lirc"
