# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jahshaka/jahshaka-1.9_alpha90.ebuild,v 1.2 2004/11/28 04:58:01 chriswhite Exp $

inherit eutils

MY_P="${P/'-1.9_alpha90'/_1.9a9}"
DESCRIPTION="The worlds first OpenSource Realtime Editing and Effects System."
HOMEPAGE="http://www.jahshaka.com"
SRC_URI="http://www.jahshaka.com/downloads/${MY_P}.tar.gz"

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

src_unpack() {
	unpack ${A}
	einfo "Patching plugins.pro"
	sed -e '/jitplugins/a csplugins \\' -i ${S}/plugins/plugins.pro

	cp ${FILESDIR}/configure ${S}/configure
}

cflags_replacement() {
	sed -e "s:^CFLAGS.*:CFLAGS   = ${CFLAGS} -Wall -W -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT:" -i $*
	sed -e "s:^CXXFLAGS.*:CXXFLAGS = ${CXXFLAGS} -Wall -W -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT:" -i $*
}

src_compile() {
	./configure || die "configure failed"
	cd ${S}/plugins
	./configure
	cd ..

	make qmake_all || die "could not create the temaplate makefiles"

	for Makefiles in $(grep -r -l '^CFLAGS' ${S}/*)
	do
		einfo "Patching "${Makefiles}
		cflags_replacement ${Makefiles}
	done

	make || die
	cd ${S}/plugins
	make || die
}

src_install() {

	cd ${S}

	# They do no harm but we don't like 'CVS' dirs in every subdir
	for i in $(ls -la -R * | grep CVS | grep / | cut -f1 -d:)
	do
	    rm -rf ${i}
	done

	local dirs="Pixmaps database docs fonts media scenes utils"
	dodir /opt/${PN}
	for i in $dirs ; do
	    cp -a ${i} ${D}/opt/${PN}/
	done

	dodir /opt/${PN}/plugins
	local dirs="csplugins jfxplugins jitplugins rfxplugins ftplugins"
	for i in $dirs ; do
	    dodir /opt/${PN}/plugins/${i}
	    cp -a ${S}/plugins/${i}/*.so ${D}/opt/${PN}/plugins/${i}/
	done

	cp -a jahshaka ${D}/opt/${PN}/

	ln -s ${D}/opt/${PN}/jahshaka ${D}/usr/bin/jahshaka

	dodoc README AUTHORS TODO
}
