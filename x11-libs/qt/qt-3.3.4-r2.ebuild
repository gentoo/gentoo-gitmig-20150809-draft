# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.3.4-r2.ebuild,v 1.15 2005/04/03 08:09:13 usata Exp $

inherit eutils flag-o-matic

SRCTYPE="free"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"

IMMQT_P="qt-x11-immodule-unified-qt3.3.4-20041203"

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV}.tar.bz2
	immqt? ( http://freedesktop.org/~daisuke/${IMMQT_P}.diff.bz2 )
	immqt-bc? ( http://freedesktop.org/~daisuke/${IMMQT_P}.diff.bz2 )"
#	ppc-macos? ( http://dev.gentoo.org/~usata/distfiles/${P}-darwin-fink.patch.gz )"

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="3"
KEYWORDS="x86 amd64 hppa mips ppc64 sparc ia64 ppc alpha"
IUSE="cups debug doc firebird gif ipv6 mysql nas odbc opengl postgres sqlite xinerama zlib immqt immqt-bc"

DEPEND="virtual/x11 virtual/xft
	media-libs/libpng media-libs/jpeg media-libs/libmng
	>=media-libs/freetype-2
	nas? ( >=media-libs/nas-1.5 )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	firebird? ( dev-db/firebird )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/postgresql )
	cups? ( net-print/cups )
	zlib? ( sys-libs/zlib )"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV}

QTBASE=/usr/qt/3
export QTDIR=${S}

pkg_setup() {
	if use immqt ; then
		ewarn
		ewarn "You are going to compile binary imcompatible immodule for Qt. This means"
		ewarn "you have to recompile everything depending on Qt after you install it."
		ewarn "Be aware."
		ewarn
	fi

	if useq ppc-macos ; then
		export PLATFORM=darwin-g++
		export DYLD_LIBRARY_PATH="${QTDIR}/lib:/usr/X11R6/lib:${DYLD_LIBRARY_PATH}"
		export INSTALL_ROOT=""
	else
		export PLATFORM=linux-g++
	fi
}

src_unpack() {
	unpack ${A}

	export QTDIR=${S}
	cd ${S}

	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

	epatch ${FILESDIR}/qt-no-rpath-uic.patch
	epatch ${FILESDIR}/qt-no-rpath.patch

	# fix freeze caused by bad interaction with kde klipper (kde bug 80072)
	epatch ${FILESDIR}/${P}-qclipboard-hack.patch

	# performance patches (see http://robotics.dei.unipd.it/~koral/KDE/kflicker.html)
	epatch ${FILESDIR}/${P}-flickerfree_qiconview_buffered.patch
	epatch ${FILESDIR}/${P}-flickerfree_qscrollview_fixwindowactivate.patch

	if use immqt || use immqt-bc ; then
		epatch ../${IMMQT_P}.diff
		epatch ${FILESDIR}/${P}-immodule-focus.patch
		sh make-symlinks.sh || die "make symlinks failed"
	fi

	if use ppc-macos ; then
		gzcat ${FILESDIR}/${P}-darwin-fink.patch.gz | sed -e "s:@QTBASE@:${QTBASE}:g" > ${T}/${P}-darwin-fink.patch
		epatch ${T}/${P}-darwin-fink.patch
	fi

	cd mkspecs/${PLATFORM}
	# set c/xxflags and ldflags
	strip-flags
	sed -i -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		qmake.conf || die
	cd ${S}
}

src_compile() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "$HOME/.qt"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif" || myconf="${myconf} -no-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql" || myconf="${myconf} -no-sql-mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf="${myconf} -no-sql-psql"
	use firebird    && myconf="${myconf} -plugin-sql-ibase" || myconf="${myconf} -no-sql-ibase"
	use sqlite	&& myconf="${myconf} -plugin-sql-sqlite" || myconf="${myconf} -no-sql-sqlite"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc" || myconf="${myconf} -no-sql-odbc"
	use cups	&& myconf="${myconf} -cups" || myconf="${myconf} -no-cups"
	use opengl	&& myconf="${myconf} -enable-module=opengl" || myconf="${myconf} -disable-opengl"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release -no-g++-exceptions"
	use xinerama    && myconf="${myconf} -xinerama" || myconf="${myconf} -no-xinerama"
	use zlib	&& myconf="${myconf} -system-zlib" || myconf="${myconf} -qt-zlib"
	use ipv6        && myconf="${myconf} -ipv6" || myconf="${myconf} -no-ipv6"
	use immqt-bc	&& myconf="${myconf} -inputmethod"
	use immqt	&& myconf="${myconf} -inputmethod -inputmethod-ext"

	if use ppc-macos ; then
		myconf="${myconf} -no-sql-ibase -no-sql-mysql -no-sql-odbc -no-sql-psql -no-cups -lresolv -shared"
		myconf="${myconf} -I/usr/X11R6/include -L/usr/X11R6/lib"
		myconf="${myconf} -L${S}/lib -I${S}/include"
		sed -i -e "s,#define QT_AOUT_UNDERSCORE,," mkspecs/${PLATFORM}/qplatformdefs.h || die
	fi

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -lpthread -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${QTBASE} -libdir ${QTBASE}/$(get_libdir) \
		-fast ${myconf} -dlopen-opengl || die

	export QTDIR=${S}

	emake src-qmake src-moc sub-src || die
	DYLD_LIBRARY_PATH="${S}/lib:/usr/X11R6/lib:${DYLD_LIBRARY_PATH}" \
	LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}" emake sub-tools || die
}

src_install() {
	export QTDIR=${S}

	# binaries
	into $QTBASE
	dobin bin/*

	# libraries
	if use ppc-macos; then
		# dolib is broken on BSD because of missing readlink(1)
		dodir ${QTBASE}/$(get_libdir)
		cp -fR lib/*.{dylib,la,a} ${D}/${QTBASE}/$(get_libdir) || die

		cd ${D}/${QTBASE}/$(get_libdir)
		for lib in libqt-mt* ; do
			ln -s ${lib} ${lib/-mt/}
		done
	else
		dolib lib/lib{editor,qassistantclient,designercore}.a
		dolib lib/libqt-mt.la
		dolib lib/libqt-mt.so.3.3.4 lib/libqui.so.1.0.0
		cd ${D}/${QTBASE}/$(get_libdir)

		for x in libqui.so ; do
			ln -s $x.1.0.0 $x.1.0
			ln -s $x.1.0 $x.1
			ln -s $x.1 $x
		done

		# version symlinks - 3.3.4->3.3->3->.so
		ln -s libqt-mt.so.3.3.4 libqt-mt.so.3.3
		ln -s libqt-mt.so.3.3 libqt-mt.so.3
		ln -s libqt-mt.so.3 libqt-mt.so

		# libqt -> libqt-mt symlinks
		ln -s libqt-mt.so.3.3.4 libqt.so.3.3.4
		ln -s libqt-mt.so.3.3 libqt.so.3.3
		ln -s libqt-mt.so.3 libqt.so.3
		ln -s libqt-mt.so libqt.so
	fi

	# plugins
	cd ${S}
	plugins=`find plugins -name "lib*.so" -print`
	for x in $plugins; do
		exeinto ${QTBASE}/`dirname $x`
		doexe $x
	done

	# Past this point just needs to be done once
	is_final_abi || return 0

	# includes
	cd ${S}
	dodir ${QTBASE}/include/private
	cp include/* ${D}/${QTBASE}/include/
	cp include/private/* ${D}/${QTBASE}/include/private/

	# misc
	insinto /etc/env.d
	doins ${FILESDIR}/{45qt3,50qtdir3}

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${QTBASE}/${libdir}"
	done
	dosed "s~^LDPATH=.*$~LDPATH=${libdirs:1}~" /etc/env.d/45qt3

	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${QTBASE}/lib
	fi

	dodir ${QTBASE}/tools/designer/templates
	cd ${S}
	cp tools/designer/templates/* ${D}/${QTBASE}/tools/designer/templates

	dodir ${QTBASE}/translations
	cd ${S}
	cp translations/* ${D}/${QTBASE}/translations

	dodir ${QTBASE}/etc
	keepdir ${QTBASE}/etc/settings

	dodir ${QTBASE}/doc

	if use doc; then
		cp -r ${S}/doc ${D}/${QTBASE}

		cd ${S}/examples
		find . -name Makefile | while read MAKEFILE
		do
			cp ${MAKEFILE} ${MAKEFILE}.old
			sed -e "s:${S}:${QTBASE}:g" ${MAKEFILE}.old > ${MAKEFILE}
			rm -f ${MAKEFILE}.old
		done

		cp -r ${S}/examples ${D}/${QTBASE}

		cd ${S}/tutorial
		find . -name Makefile | while read MAKEFILE
		do
			cp ${MAKEFILE} ${MAKEFILE}.old
			sed -e "s:${S}:${QTBASE}:g" ${MAKEFILE}.old > ${MAKEFILE}
			rm -f ${MAKEFILE}.old
		done

		cp -r ${S}/tutorial ${D}/${QTBASE}
	fi

	if use immqt || use immqt-bc ; then
		dodoc ${S}/README.immodule
	fi

	# misc build reqs
	dodir ${QTBASE}/mkspecs
	cp -R ${S}/mkspecs/${PLATFORM} ${D}/${QTBASE}/mkspecs/

	sed -e "s:${S}:${QTBASE}:g" \
		${S}/.qmake.cache > ${D}${QTBASE}/.qmake.cache

	if use ppc-macos ; then
		dosed "s:linux-g++:${PLATFORM}:" /etc/env.d/45qt3 \
			"s:\$(QTBASE):\$(QTDIR):g" ${QTBASE}/mkspecs/${PLATFORM}/qmake.conf \
			"s:${S}:${QTBASE}:g" ${QTBASE}/mkspecs/${PLATFORM}/qmake.conf ${QTBASE}/lib/libqt-mt.la || die
	fi
}
