# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm_icons/fvwm_icons-1.0.ebuild,v 1.4 2003/09/01 17:51:53 taviso Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Icons for use with FVWM"
SRC_URI="http://www.fvwm.org/generated/icon_download/fvwm_icons.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

DEPEND="x11-wm/fvwm"
KEYWORDS="x86 alpha ~sparc"
SLOT="0"
LICENSE="GPL-2 FVWM"

src_install () {
    dodir /usr/share/icons/fvwm
    insinto /usr/share/icons/fvwm
    doins ${S}/*
}
