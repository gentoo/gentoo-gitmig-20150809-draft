# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.2.0-r1.ebuild,v 1.2 2005/01/10 18:08:42 bcowan Exp $

DESCRIPTION="Extension library for Xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

XRDEPEND=">=x11-libs/gtk+-2.4*
	>=sys-apps/dbus-0.22"
MY_P="${PN/t/T}-${PV}"
BZIPPED=1
GOODIES=1

inherit xfce4
