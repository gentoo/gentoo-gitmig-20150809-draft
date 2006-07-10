# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/mousepad/mousepad-0.2.6.ebuild,v 1.1 2006/07/10 18:39:13 bcowan Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce4 text editor"
SRC_URI="http://www.xfce.org/archive/xfce-${XFCE_MASTER_VERSION}/src/${P}${COMPRESS}"
HOMEPAGE="http://www.xfce.org"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4util-4.3.90.1
	>=xfce-base/libxfcegui4-4.3.90.1"
