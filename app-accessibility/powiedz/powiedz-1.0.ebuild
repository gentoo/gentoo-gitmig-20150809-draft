# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/powiedz/powiedz-1.0.ebuild,v 1.14 2008/02/25 22:26:55 wolf31o2 Exp $

inherit eutils

IUSE="arts esd"

DESCRIPTION="Polish speech synthesizer based on rsynth"
HOMEPAGE="http://kadu.net/index.php?page=download&lang=en"
SRC_URI="http://kadu.net/download/additions/powiedz-1.0.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND="esd? ( media-sound/esound )
	arts? ( kde-base/arts )"

DEPEND="${RDEPEND}
	esd? ( dev-util/pkgconfig )"

S=${WORKDIR}/${PN}

src_compile() {
	cflags=${CFLAGS}
	ldlibs="-lm"

	if use esd; then
		ldlibs="${ldlibs} `esd-config --libs`"
		defs="${defs} -DUSE_ESD=1"
		cflags="${cflags} `esd-config --cflags`"
	fi

	if use arts; then
		ldlibs="${ldlibs} `artsc-config --libs`"
		defs="${defs} -DUSE_ARTS=1"
		cflags="${cflags} `artsc-config --cflags`"
	fi

	cd "${S}"

	epatch "${FILESDIR}"/${PN}-dsp-handle-fix.patch
	emake -f Makefile_plain LDLIBS="${ldlibs}" CFLAGS="${cflags}" DEFS="${defs}" || die "make failed"
}

src_install() {
	dobin powiedz
	domenu "${FILESDIR}"/${PN}.desktop
}
