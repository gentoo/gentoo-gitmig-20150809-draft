# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.2.2.ebuild,v 1.1 2005/05/18 02:57:26 bcowan Exp $

DESCRIPTION="Xfce 4 desktop manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="~xfce-base/xfce4-panel-${PV}"

inherit xfce4
