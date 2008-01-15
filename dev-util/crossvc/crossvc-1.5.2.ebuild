# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crossvc/crossvc-1.5.2.ebuild,v 1.3 2008/01/15 21:20:29 mpagano Exp $

inherit kde-functions

MY_P="${P/_/-}-0-generic-src"

DESCRIPTION="A graphical version-control program for cvs"
HOMEPAGE="http://www.crossvc.com/"
SRC_URI="http://www.crossvc.com/download/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde"

DEPEND="kde? ( >=kde-base/kdelibs-3 )
	( $(qt_min_version 3.3.0) <x11-libs/qt-4 )"
RDEPEND="${DEPEND}
	dev-util/cvs"

S="${WORKDIR}/CrossVC"

src_compile() {
	eqmake3 lincvs.pro
	sed -i -e "s/^\t-strip/#\tstrip/" \
		-e "s/CFLAGS   = -pipe -Wall -W -march=prescott -O2 -pipe -D_REENTRANT  -DUSE_TM_GMTOFF -DNANOSLEEP -DQT_NO_DEBUG -DQT_THREAD_SUPPORT -DQT_SHARED -DQT_TABLET_SUPPORT/CFLAGS   = ${CFLAGS} -Wall -W/" \
		-e "s/CXXFLAGS = -pipe -Wall -W -march=prescott -O2 -pipe -D_REENTRANT  -DUSE_TM_GMTOFF -DNANOSLEEP -DQT_NO_DEBUG -DQT_THREAD_SUPPORT -DQT_SHARED -DQT_TABLET_SUPPORT/CXXFLAGS = ${CXXFLAGS} -Wall -W/" Makefile \
	|| die "sed failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	echo "#!/bin/sh" > "${S}"/CrossVC/crossvc
	echo "exec /usr/share/CrossVC/AppRun" >> "${S}"/CrossVC/crossvc
	dobin CrossVC/crossvc
	rm "${S}"/CrossVC/crossvc

	dodir /usr/share
	cp -pr "${S}"/CrossVC "${D}"/usr/share
	cp -pr "${S}"/tools "${D}"/usr/share/CrossVC

	dodir /usr/share/pixmaps
	cp "${S}"/images/lincvs-16.xpm "${D}"/usr/share/pixmaps/crossvc-16.xpm
	make_desktop_entry crossvc "CrossVC" crossvc-16.xpm

	for i in /usr/share/CrossVC/{AppI*,Messages} ; do
		fperms 644 "${i}"
	done

	for i in /usr/share/CrossVC/{AppRun,tools} ; do
		fperms 755 "${i}"
	done

	dodoc doc/{DNOTIFY-HOWTO.txt,EXPORT-CHANGE-IMPORT.txt,FAM-HOWTO.txt,FAQ.txt,INFO.txt,INSTALL,INSTALL.html,PROXY-HOWTO.txt,README,README.html,SSH-HOWTO.txt}
	dodoc doc/translations/{de,it,ru}/*
}
