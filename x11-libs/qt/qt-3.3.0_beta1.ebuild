# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.3.0_beta1.ebuild,v 1.11 2004/01/05 02:57:25 caleb Exp $

SRCTYPE="free"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"

MY_PV=${PV/_beta1/b1}
SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${MY_PV}.tar.bz2"

LICENSE="QPL-1.0 | GPL-2"
SLOT="3"
KEYWORDS="~x86"
IUSE="cups nas postgres opengl mysql odbc gif doc firebird zlib icc sqlite"

DEPEND="virtual/x11 virtual/xft
	media-libs/libpng media-libs/jpeg media-libs/libmng
	>=media-libs/freetype-2
	gif? ( media-libs/giflib media-libs/libungif )
	nas? ( >=media-libs/nas-1.5 )
	odbc? ( dev-db/unixODBC )
	mysql? ( dev-db/mysql )
	sqlite? ( dev-db/sqlite )
	firebird? ( dev-db/firebird )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/postgresql )
	cups? ( net-print/cups )
	zlib? ( sys-libs/zlib )
	icc? ( dev-lang/icc )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${MY_PV}

QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {
	unpack ${A}

	export QTDIR=${S}
	cd ${S}

	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

	epatch ${FILESDIR}/${P}-freetype.patch

	export PLATFORM=linux-g++
	use icc && export PLATFORM=linux-icc
	use amd64 && export PLATFORM=linux-g++-64
	use ia64 && export PLATFORM=linux-g++-64
}

src_compile() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTBASE}/etc/settings
	LD_LIBRARY_PATH_OLD=${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH=${S}/lib:${LD_LIBRARY_PATH}

	# fix #11144; qt wants to create lock files etc. in that directory
	# [ -d "$QTBASE/etc/settings" ] && addwrite "$QTBASE/etc/settings"
	# [ ! -d "$QTBASE/etc/settings" ] && dodir ${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "$HOME/.qt"
	dodir "${QTBASE}/etc/settings"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server"
	use firebird    && myconf="${myconf} -plugin-sql-ibase"
#	use oci8	&& myconf="${myconf} -plugin-sql-oci"
	use sqlite	&& myconf="${myconf} -plugin-sql-sqlite"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	use cups	&& myconf="${myconf} -cups" || myconf="${myconf} -no-cups"
	use opengl	&& myconf="${myconf} -enable-module=opengl" || myconf="${myconf} -disable-opengl"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release -no-g++-exceptions"
	use xinerama    && myconf="${myconf} -xinerama"
	use zlib	&& myconf="${myconf} -system-zlib" || myconf="${myconf} -qt-zlib"
	use ipv6        && myconf="${myconf} -ipv6" || myconf="${myconf} -no-ipv6"

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -lpthread -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${D}${QTBASE} -plugindir ${QTBASE}/plugins \
		-docdir ${QTBASE}/doc -translationdir ${QTBASE}/translations \
		-datadir ${QTBASE} -sysconfdir ${QTBASE}/etc/settings -fast ${myconf} -dlopen-opengl || die

	export QTDIR=${S}
	emake src-qmake src-moc sub-src sub-tools || die
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH_OLD}
	export HOME="$REALHOME"
}

src_install() {
	export QTDIR=${S}

	# binaries
	into $QTBASE
	dobin bin/*

	# libraries
	dolib lib/libqt-mt.so.3.3.0 lib/libqui.so.1.0.0 lib/lib{editor,qassistantclient,designercore}.a
	cd ${D}/$QTBASE/lib
	for x in libqui.so ; do
		ln -s $x.1.0.0 $x.1.0
		ln -s $x.1.0 $x.1
		ln -s $x.1 $x
	done

	# version symlinks - 3.3.0->3.3->3->.so
	ln -s libqt-mt.so.3.3.0 libqt-mt.so.3.3
	ln -s libqt-mt.so.3.3 libqt-mt.so.3
	ln -s libqt-mt.so.3 libqt-mt.so

	# libqt -> libqt-mt symlinks
	ln -s libqt-mt.so.3.3.0 libqt.so.3.3.0
	ln -s libqt-mt.so.3.3 libqt.so.3.3
	ln -s libqt-mt.so.3 libqt.so.3
	ln -s libqt-mt.so libqt.so

	# includes
	cd ${S}
	dodir ${QTBASE}/include/private
	cp include/* ${D}/${QTBASE}/include/
	cp include/private/* ${D}/${QTBASE}/include/private/

	# misc
	insinto /etc/env.d
	doins ${FILESDIR}/{45qt3,50qtdir3}

	dodir ${QTBASE}/tools/designer/templates
	cd ${S}
	cp tools/designer/templates/* ${D}/${QTBASE}/tools/designer/templates

	dodir ${QTBASE}/translations
	cd ${S}
	cp translations/* ${D}/${QTBASE}/translations

	dodir ${QTBASE}/doc

	if [ `use doc` ]; then
		cd ${S}/doc
		for x in html flyers; do
			cp -r $x ${D}/${QTBASE}/doc
		done

		cp -r ${S}/doc/man ${D}/${QTBASE}
		cp -r ${S}/examples ${D}/${QTBASE}
		cp -r ${S}/tutorial ${D}/${QTBASE}
	fi

	# misc build reqs
	dodir ${QTBASE}/mkspecs
	cp -R ${S}/mkspecs/${PLATFORM} ${D}/${QTBASE}/mkspecs/

	sed -e "s:${S}:${QTBASE}:g" \
		${S}/.qmake.cache > ${D}${QTBASE}/.qmake.cache

	# plugins
	cd ${S}
	plugins=`find plugins -name "lib*.so" -print`
	for x in $plugins; do
		insinto ${QTBASE}/`dirname $x`
		doins $x
	done
}
