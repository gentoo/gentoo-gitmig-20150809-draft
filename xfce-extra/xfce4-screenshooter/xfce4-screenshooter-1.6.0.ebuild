# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-screenshooter/xfce4-screenshooter-1.6.0.ebuild,v 1.2 2009/08/23 16:45:14 ssuominen Exp $

EAPI="1"

inherit xfce4

xfce4_gzipped
xfce4_goodies

DESCRIPTION="Xfce4 screenshooter application and panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="zimagez"

DEPEND="xfce-base/xfce4-panel
        zimagez? ( dev-libs/xmlrpc-c
                net-misc/curl )"
RDEPEND="${DEPEND}"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable zimagez curl)
		$(use_enable zimagez xmlrpc-c)"
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
