# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jahshaka/jahshaka-1.9_alpha5.ebuild,v 1.2 2004/09/03 01:01:14 dholm Exp $

inherit eutils

MY_P="${P/'-1.9_alpha'/_1.9a}"
DESCRIPTION="The worlds first OpenSource Realtime Editing and Effects System."
HOMEPAGE="http://www.jahshaka.com"
SRC_URI="mirror://sourceforge/${PN}fx/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/x11
	>=media-libs/glut-3.7.1
	>=media-libs/freetype-2.1.4
	>=x11-libs/qt-3"

RDEPEND=${DEPEND}

S="${WORKDIR}/${PN}"
JAH_SRC=${S}/jah

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ftgl.h.patch || die
	epatch ${FILESDIR}/FT_Open_Flags.patch || die
}

cflags_replacement() {
	sed -e "s:^CFLAGS.*:CFLAGS   = ${CFLAGS} -Wall -W -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT:" -i $*
	sed -e "s:^CXXFLAGS.*:CXXFLAGS = ${CXXFLAGS} -Wall -W -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT:" -i $*
}

src_compile() {
	./configure || die "configure failed"

	make qmake_all || die "could not create the temaplate makefiles"

	local sources="Source Core/Objects Core/Render Core/World libraries desktop network player sqlite objectlibs/FTGL objectlibs/glmlib objectlibs/l3ds objectlibs/particle Modules/animate Modules/color Modules/edit Modules/effect Modules/painter Modules/text encoders/mpeg_encode encoders/mpeg_play"

	for Makefiles in $sources
	do
		cflags_replacement ${JAH_SRC}/${Makefiles}/Makefile
	done

	make || die
}

src_install() {

	# They do no harm but we don't like 'CVS' dirs in every subdir
	for i in $(ls -la -R * | grep CVS | grep / | cut -f1 -d:)
	do
	    rm -rf ${i}
	done

	local dirs="Pixmaps database fonts media scenes"
	dodir /opt/${PN}
	for i in $dirs ; do
	    cp -a $i ${D}/opt/${PN}/
	done

	cp -a jahshaka ${D}/opt/${PN}/

	ln -s ${D}/opt/${PN}/jahshaka ${D}/usr/bin/jahshaka

	dodoc README AUTHORS TODO
}

