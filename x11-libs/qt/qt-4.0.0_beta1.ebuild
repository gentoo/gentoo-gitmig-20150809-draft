# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-4.0.0_beta1.ebuild,v 1.2 2005/01/08 10:36:27 eradicator Exp $

inherit eutils flag-o-matic

SRCTYPE="opensource"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV/_beta1/-b1}.tar.bz2"

LICENSE="|| ( QPL-1.0 GPL-2 )"
SLOT="4"
KEYWORDS="-*"
IUSE="accessibility cups debug doc firebird gif icc ipv6 mysql nas nis odbc opengl postgres sqlite xinerama zlib"

DEPEND="virtual/x11 virtual/xft
	media-libs/libpng media-libs/jpeg media-libs/libmng
	>=media-libs/freetype-2
	gif? ( media-libs/giflib media-libs/libungif )
	nas? ( >=media-libs/nas-1.5 )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	sqlite? ( =dev-db/sqlite-2* )
	firebird? ( dev-db/firebird )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/postgresql )
	cups? ( net-print/cups )
	zlib? ( sys-libs/zlib )
	icc? ( dev-lang/icc )"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV/_beta1/-b1}

QTPREFIXDIR=${S}
QTBINDIR=/usr/lib/qt4/bin
QTLIBDIR=/usr/lib/qt4
QTDOCDIR=/usr/lib/qt4/doc
QTHEADERDIR=/usr/include/qt4
QTPLUGINDIR=/usr/lib/qt4/plugins
QTSYSCONFDIR=/etc/qt4
QTTRANSDIR=/usr/lib/qt4/translations

export QTDIR=${S}
export PLATFORM=linux-g++

qt_use() {
	if useq $1; then
		echo "-${1}"
	else
		echo "-no-${1}"
	fi
	return 0
}

src_unpack() {
	unpack ${A}

	export QTDIR=${S}
	cd ${S}

	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

#	epatch ${FILESDIR}/qt-no-rpath-uic.patch

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
	epatch ${FILESDIR}/qt4b1.patch
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
	use gif		&& myconf="${myconf} -qt-gif"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release"
	use zlib	&& myconf="${myconf} -system-zlib" || myconf="${myconf} -qt-zlib"

	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql" || myconf="${myconf} -no-sql-mysql"
	use postgres && myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf="${myconf} -no-sql-psql"
	use firebird && myconf="${myconf} -plugin-sql-ibase" || myconf="${myconf} -no-sql-ibase"
	use sqlite	&& myconf="${myconf} -plugin-sql-sqlite" || myconf="${myconf} -no-sql-sqlite"
	use odbc		&& myconf="${myconf} -plugin-sql-odbc" || myconf="${myconf} -no-sql-odbc"

	export YACC='byacc -d'

	./configure -stl -verbose -largefile \
		-qt-imgfmt-{jpeg,png} -system-lib{jpeg,png} -fast \
		-platform ${PLATFORM} -xplatform ${PLATFORM} \
		-tablet -xft -xrender -xrandr -xkb -xshape -sm \
		-prefix ${QTPREFIXDIR} -bindir ${QTBINDIR} -libdir ${QTLIBDIR} \
		-docdir ${QTDOCDIR} -headerdir ${QTHEADERDIR} -plugindir ${QTPLUGINDIR} \
		-sysconfdir ${QTSYSCONFDIR} -translationdir ${QTTRANSDIR} ${myconf} || die

	emake sub-tools-all-ordered sub-demos-all-ordered sub-examples-all-ordered || die
	use doc && emake sub-tutorial-all-ordered
}

src_install() {
	# Setup the symlinks if libdir isn't "lib"
	if [ "$(get_libdir)" != "lib" ]; then
		dodir ${QTBASE}/$(get_libdir)
		dosym $(get_libdir) ${QTBASE}/lib
	fi

	export QTDIR=${S}
	export SYSCONF=${D}${QTPREFIXDIR}/etc/settings
	export PATH="${S}/bin:${PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	make INSTALL_ROOT=${D} sub-src-install_subtargets-ordered sub-tools-install_subtargets-ordered || die
	make INSTALL_ROOT=${D} sub-demos-install_subtargets-ordered sub-examples-install_subtargets-ordered || die
	use doc && make INSTALL_ROOT=${D} install_htmldocs sub-tutorial-install_subtargets-ordered

#	dodir /usr/qt4/bin
#	into /usr/qt4
#	dobin assistant designer findtr linguist lrelease lupdate moc qm2ts qmake qt3to4 qtconfig rcc syncqt uic uic3

#	insinto /etc/env.d
#	doins ${FILESDIR}/{45qt3,50qtdir3}
}
