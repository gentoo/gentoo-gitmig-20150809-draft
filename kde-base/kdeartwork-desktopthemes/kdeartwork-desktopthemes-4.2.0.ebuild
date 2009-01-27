# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-desktopthemes/kdeartwork-desktopthemes-4.2.0.ebuild,v 1.1 2009/01/27 16:46:34 alexxy Exp $

EAPI="2"

KMMODULE="desktopthemes"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Additional themes from kde"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
		!kdeprefix? ( !<kde-base/kdeplasma-addons-${PV}:${SLOT}[kdeprefix=] )"
