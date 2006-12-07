# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-bglist-editor/xfce4-bglist-editor-4.2.0-r1.ebuild,v 1.2 2006/12/07 05:12:24 nichoj Exp $

inherit xfce42

goodies

DESCRIPTION="Xfce4 background list editor"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND="${RDEPEND}
	|| ( ( x11-libs/libX11
	x11-proto/xproto )
	virtual/x11 )"
