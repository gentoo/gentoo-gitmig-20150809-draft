# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/powiedz/powiedz-1.0.ebuild,v 1.3 2004/07/20 14:23:11 spock Exp $

inherit eutils

IUSE="arts esd"

DESCRIPTION="Polish speech synthesizer based on rsynth"
HOMEPAGE="http://kadu.net/index.php?page=download&lang=en"
SRC_URI="http://kadu.net/download/additions/powiedz-1.0.tgz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="esd? ( media-sound/esound )
	arts? ( kde-base/arts )"

S=${WORKDIR}/${PN}

src_compile() {
	cflags=${CFLAGS}

	if use esd; then
		ldlibs="${ldlibs} -lesd"
		defs="${defs} -DUSE_ESD=1"
	fi

	if use arts; then
		ldlibs="${ldlibs} `artsc-config --libs`"
		defs="${defs} -DUSE_ARTS=1"
		cflags="${cflags} `artsc-config --cflags`"
	fi

	cd ${S}

	epatch ${FILESDIR}/${PN}-dsp-handle-fix.patch || die "patching failed"
	emake -f Makefile_plain LDLIBS="${ldlibs}" CFLAGS="${cflags}" DEFS="${defs}" || die "make failed"
}

src_install() {
	cd ${S}

	exeinto /usr/bin
	doexe powiedz

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
