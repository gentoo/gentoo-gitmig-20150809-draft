# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later


S=${WORKDIR}
DESCRIPTION="Sounds for use with FVWM"
SRC_URI="http://www.fvwm.org/generated/sounds_download/fvwm_sounds.tgz"
HOMEPAGE="http://www.fvwm.org/"

DEPEND="x11-wm/fvwm"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2 FVWM"

src_install () {
    dodir /usr/share/sounds/fvwm
    insinto /usr/share/sounds/fvwm
    doins ${S}/*
}
