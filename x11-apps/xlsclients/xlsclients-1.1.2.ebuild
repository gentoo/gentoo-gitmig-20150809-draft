# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlsclients/xlsclients-1.1.2.ebuild,v 1.4 2011/06/28 21:21:06 ranger Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="X.Org xlsclients application"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=x11-libs/libxcb-1.7
	>=x11-libs/xcb-util-0.3.8
"
DEPEND="${RDEPEND}"
