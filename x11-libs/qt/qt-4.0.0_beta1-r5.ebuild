# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-4.0.0_beta1-r5.ebuild,v 1.1 2005/03/18 12:07:32 caleb Exp $

inherit eutils flag-o-matic

SRCTYPE="opensource"
SNAPSHOT="20050317"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"

SRC_URI="ftp://ftp.trolltech.com/qt/snapshots/qt-x11-${SRCTYPE}-${PV/_beta1/-b2}-snapshot-${SNAPSHOT}.tar.bz2"

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="-*"
IUSE="accessibility cups debug doc firebird gif ipv6 mysql nas nis odbc opengl postgres sqlite xinerama zlib"

DEPEND="virtual/x11 virtual/xft
	media-libs/libpng media-libs/jpeg media-libs/libmng
	>=media-libs/freetype-2
	nas? ( >=media-libs/nas-1.5 )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	sqlite? ( =dev-db/sqlite-2* )
	firebird? ( dev-db/firebird )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/postgresql )
	cups? ( net-print/cups )
	zlib? ( sys-libs/zlib )"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV/_beta1/-b2}-snapshot-${SNAPSHOT}

pkg_setup() {
	QTBASEDIR=/usr/$(get_libdir)/qt4
	QTPREFIXDIR=${S}
	QTBINDIR=/usr/libexec/qt4
	QTLIBDIR=/usr/$(get_libdir)/qt4
	QTDOCDIR=/usr/share/qt4/doc
	QTDATADIR=/usr/share/qt4
	QTHEADERDIR=/usr/include/qt4
	QTPLUGINDIR=/usr/$(get_libdir)/qt4/plugins
	QTSYSCONFDIR=/etc/qt4
	QTTRANSDIR=/usr/share/qt4/translations

	export QTDIR=${S}
	export PLATFORM=linux-g++
}

qt_use() {
	useq ${1} && echo "-${1}" || echo "-no-${1}"
	return 0
}

src_unpack() {
	unpack ${A}

	export QTDIR=${S}
	cd ${S}

	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

	cd mkspecs/linux-g++
	# set c/xxflags and ldflags
	strip-flags

	# Qt4 moc does not work with -O3, unfortunately.
	replace-flags -O3 -O2
	filter-flags -finline-functions

	sed -i -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		qmake.conf
	cd ${S}

	epatch ${FILESDIR}/qt4-rpath.patch
	epatch ${FILESDIR}/qt4b1_20050302.patch
	epatch ${FILESDIR}/qt4b1_nomkdir.patch

	sed -i -e "s:CFG_REDUCE_EXPORTS=auto:CFG_REDUCE_EXPORTS=no:" configure
}

src_compile() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTPREFIXDIR}/etc/settings
	export PATH="${S}/bin:${PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "$HOME/.qt"

	myconf="${myconf} $(qt_use accessibility) $(qt_use cups) $(qt_use xinerama)"
	myconf="${myconf} $(qt_use opengl) $(qt_use nis)"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif" || myconf="${myconf} -no-gif"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release"
	use zlib	&& myconf="${myconf} -system-zlib" || myconf="${myconf} -qt-zlib"

	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/$(get_libdir)/mysql" || myconf="${myconf} -no-sql-mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf="${myconf} -no-sql-psql"
	use firebird	&& myconf="${myconf} -plugin-sql-ibase" || myconf="${myconf} -no-sql-ibase"
	use sqlite	&& myconf="${myconf} -plugin-sql-sqlite" || myconf="${myconf} -no-sql-sqlite"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc" || myconf="${myconf} -no-sql-odbc"

	export YACC='byacc -d'

	./configure -stl -verbose -largefile \
		-qt-imgfmt-{jpeg,png} -system-lib{jpeg,png} \
		-platform ${PLATFORM} -xplatform ${PLATFORM} \
		-tablet -xft -xrender -xrandr -xkb -xshape -sm \
		-prefix ${QTPREFIXDIR} -bindir ${QTBINDIR} -libdir ${QTLIBDIR} -datadir ${QTDATADIR} \
		-docdir ${QTDOCDIR} -headerdir ${QTHEADERDIR} -plugindir ${QTPLUGINDIR} \
		-sysconfdir ${QTSYSCONFDIR} -translationdir ${QTTRANSDIR} ${myconf} || die

	emake sub-tools-all-ordered || die
	# emake sub-demos sub-examples || die
	# use doc && emake sub-tutorial
}

src_install() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTPREFIXDIR}/etc/settings
	export PATH="${S}/bin:${PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	# make INSTALL_ROOT=${D} sub-demos-install_subtargets-ordered sub-examples-install_subtargets-ordered || die
	# make INSTALL_ROOT=${D} install_qmake sub-tools-install_subtargets-ordered || die
	# Using install_qmake forces lots of other things to build.  Bypass it for now.

	make INSTALL_ROOT=${D} sub-tools-install_subtargets-ordered || die
	install -c ${S}/bin/qmake ${D}${QTBINDIR}/qmake
	use doc && make INSTALL_ROOT=${D} install_htmldocs

	# sub-tutorial-install_subtargets-ordered

	dodir /etc/env.d
	dodir ${QTDATADIR}/mkspecs/linux-g++
	dodir ${QTDATADIR}/mkspecs/features/unix

	install -c ${S}/qt.conf ${D}${QTBASEDIR}/qt.conf
	install -c ${S}/mkspecs/linux-g++/qmake.conf ${D}${QTDATADIR}/mkspecs/linux-g++
	install -c ${S}/mkspecs/linux-g++/qplatformdefs.h ${D}${QTDATADIR}/mkspecs/linux-g++
	install -c ${S}/mkspecs/features/unix/*.prf ${D}${QTDATADIR}/mkspecs/features/unix
	install -c ${S}/mkspecs/features/*.prf ${D}${QTDATADIR}/mkspecs/features
	install -c ${S}/mkspecs/default ${D}${QTDATADIR}/mkspecs/default
	install -c ${S}/mkspecs/.qt.config ${D}${QTDATADIR}/mkspecs

	sed -i -e "s:${S}:${QTBASEDIR}:g" ${D}/${QTBASEDIR}/qt.conf
	sed -i -e "s:${S}/lib:${QTLIBDIR}:g" ${D}/${QTLIBDIR}/*.la
	sed -i -e "s:${S}/lib:${QTLIBDIR}:g" ${D}/${QTLIBDIR}/pkgconfig/*.pc

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:/usr/${libdir}/qt4"
	done
	cat > ${D}/etc/env.d/44qt4 << EOF
PATH=${QTBINDIR}
ROOTPATH=${QTBINDIR}
LDPATH=${libdirs:1}
QMAKESPEC=linux-g++
EOF
}
