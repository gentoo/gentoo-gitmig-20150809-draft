# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/powiedz/powiedz-1.0.ebuild,v 1.12 2005/08/24 15:59:53 flameeyes Exp $

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
		ldlibs="${ldlibs} -lesd -lpthread -ldl"
		defs="${defs} -DUSE_ESD=1"
	fi

	if use arts; then
		ldlibs="${ldlibs} `artsc-config --libs`"
		defs="${defs} -DUSE_ARTS=1"
		cflags="${cflags} `artsc-config --cflags`"
	fi

	cd ${S}

	epatch ${FILESDIR}/${PN}-dsp-handle-fix.patch
	emake -f Makefile_plain LDLIBS="${ldlibs}" CFLAGS="${cflags}" DEFS="${defs}" || die "make failed"
}

src_install() {
	cd ${S}

	exeinto /usr/bin
	doexe powiedz

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
