# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crossvc/crossvc-1.5.2.ebuild,v 1.11 2009/11/13 19:02:27 ssuominen Exp $

EAPI=1

inherit qt3

MY_P="${P/_/-}-0-generic-src"

DESCRIPTION="A graphical version-control program for cvs"
HOMEPAGE="http://www.crossvc.com/"
SRC_URI="http://www.crossvc.com/download/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="x11-libs/qt:3"
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
	make_desktop_entry crossvc "CrossVC" crossvc-16

	fperms 644 "/usr/share/CrossVC/AppIcon.xpm"
	fperms 644 "/usr/share/CrossVC/AppInfo.xml"

	for i in /usr/share/CrossVC/{AppRun,tools,Messages} ; do
		fperms 755 "${i}"
	done

	dodoc doc/{DNOTIFY-HOWTO.txt,EXPORT-CHANGE-IMPORT.txt,FAM-HOWTO.txt,FAQ.txt,INFO.txt,INSTALL,INSTALL.html,PROXY-HOWTO.txt,README,README.html,SSH-HOWTO.txt}
	dodoc doc/translations/{de,it,ru}/*
}
