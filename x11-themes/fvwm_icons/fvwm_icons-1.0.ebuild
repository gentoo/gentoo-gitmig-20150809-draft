# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/fvwm_icons/fvwm_icons-1.0.ebuild,v 1.3 2003/02/13 17:37:22 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Icons for use with FVWM"
SRC_URI="http://www.fvwm.org/generated/icon_download/fvwm_icons.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

DEPEND="x11-wm/fvwm"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2 FVWM"

src_install () {
    dodir /usr/share/icons/fvwm
    insinto /usr/share/icons/fvwm
    doins ${S}/*
}
