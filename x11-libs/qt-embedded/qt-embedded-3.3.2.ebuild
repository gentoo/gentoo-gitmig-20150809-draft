# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-embedded/qt-embedded-3.3.2.ebuild,v 1.3 2004/11/06 07:44:32 mr_bones_ Exp $

DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-embedded-free-${PV}.tar.bz2"

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="3"
KEYWORDS="~x86"
IUSE="gif opengl mysql odbc postgres debug build doc"

DEPEND="media-libs/lcms
	>=media-libs/freetype-2
	!build? (
		media-libs/libpng
		media-libs/jpeg
		>=media-libs/libmng-1.0.0
		odbc? ( >=dev-db/unixODBC-2.0 )
		mysql? ( >=dev-db/mysql-3.2.10 )
		opengl? ( virtual/opengl virtual/glu )
		postgres? ( >=dev-db/postgresql-7.2 )
	)"

S=${WORKDIR}/qt-embedded-free-${PV}

QTBASE=/usr/qt/3-embedded
export QTDIR=${S}

pkg_setup() {
	if use build; then
		return 0
	else
		ewarn "Note: this will build a rather bloated qt/e, with all features enabled."
		ewarn "It may be suitable for testing, but definitely not for real embedded systems"
		ewarn "where memory is precious. I advise you select your own featureset (e.g. by"
		ewarn "editing this ebuild) if building for such a system."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure
}

src_compile() {
	export QTDIR=${S}

	if ! use build; then
		# ordinary setup, rather bloated
		use gif && myconf="${myconf} -qt-gif"
		use mysql && myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql" || myconf="${myconf} -no-sql-mysql"
		use postgres && myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf="${myconf} -no-sql-psql"
		use odbc && myconf="${myconf} -plugin-sql-odbc" || myconf="${myconf} -no-sql-odbc"
		use debug && myconf="${myconf} -debug" || myconf="${myconf} -release -no-g++-exceptions"
		use x86 && myconf="$myconf -embedded x86" || myconf="$myconf -xplatform generic -embedded generic"

		./configure $myconf -shared -depths 8,16,24,32 -system-zlib -thread -stl \
			-freetype -qvfb -plugin-imgfmt-{jpeg,mng,png} -system-lib{png,jpeg,mng} \
			-prefix ${QTBASE} || die
	else
		# use build == we're building for the gentoo intaller project
		# and know exactly which features we'll need
		# not all of these features are as yet reflected in the configure call below
		#png only, builtin. also zlib, system.
		#no sql or other fancy stuff.
		#no debug
		#thread support
		#freetype2 support
		#vnc
		#all styles as plugins
		./configure -depths 8,16 -no-gif -no-lib{jpeg,mng} -qt-libpng -system-zlib \
			-release -no-g++-exceptions -no-qvfb -thread -freetype -vnc  || die
	fi

	emake symlinks src-qmake src-moc sub-src sub-tools || die "making main"
	cd ${S}/tools/designer/uic && emake || die "making uic"
	cd ${S}/tools/assistant/lib && emake || die "making qassistantclientlib"

	if ! use doc; then
		cd ${S} && emake sub-tutorial || die "making tutorial"
		LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}" \
			cd ${S} && emake sub-examples || die "making examples"
	fi
}

src_install() {
	INSTALL_ROOT=${D} emake install

	# symlinks shouldn't be necessary! The qmakespec file tells qmake to use the
	# correct library. Uncomment these if it causes a problem
	# libqt -> libqt-mt symlinks
#	into ${QTBASE}/lib
#    dosym libqte-mt.so.3.3.2 ${QTBASE}/lib/libqt.so.3.3.2
#    dosym libqte-mt.so.3.3 ${QTBASE}/lib/libqt.so.3.3
#    dosym libqte-mt.so.3 ${QTBASE}/lib/libqt.so.3
#    dosym libqte-mt.so ${QTBASE}/lib/libqt.so
#    dosym libqte-mt.so.3.3.2 ${QTBASE}/lib/libqt-mt.so.3.3.2
#    dosym libqte-mt.so.3.3 ${QTBASE}/lib/libqt-mt.so.3.3
#    dosym libqte-mt.so.3 ${QTBASE}/lib/libqt-mt.so.3
#    dosym libqte-mt.so ${QTBASE}/lib/libqt-mt.so

	# fonts
	dodir ${QTBASE}/lib/fonts
	insinto ${QTBASE}/lib/fonts
	doins ${S}/lib/fonts/*

	# environment variables
	insinto /etc/env.d
	doins ${FILESDIR}/{47qt-embedded3,50qt-embeddeddir3}

	# qmake cache file
	dodir ${QTBASE}/mkspecs/linux-g++
	insinto ${QTBASE}/mkspecs/linux-g++
	cd ${S}
	doins mkspecs/linux-g++/*
	sed -e "s:${S}:${QTBASE}:" .qmake.cache > .qmake.cache.fixed
	insinto ${QTBASE}
	newins .qmake.cache.fixed .qmake.cache

	# documentation
	if use doc; then
		cp -r ${S}/{examples,tutorial}  ${D}/${QTBASE}
		cd ${D}/${QTBASE}
		find examples tutorial -name Makefile -exec sed -i -e 's:${S}:${QTBASE}:g' {} \;
	fi

	# default target link (overriden by QMAKESPEC env var)
	cd ${D}/${QTBASE}/mkspecs
	rm -f default
	ln -s qws/linux-x86-g++ default
}
