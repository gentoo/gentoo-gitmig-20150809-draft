# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.3.3.ebuild,v 1.15 2004/10/19 14:20:32 vapier Exp $

inherit eutils

SRCTYPE="free"
DESCRIPTION="QT version ${PV}"
HOMEPAGE="http://www.trolltech.com/"

IMMQT_P="qt-x11-immodule-unified-qt3.3.3-20040819"

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV}.tar.bz2
	immqt? ( http://freedesktop.org/Software/ImmoduleQtDownload/${IMMQT_P}.diff.gz )
	immqt-bc? ( http://freedesktop.org/Software/ImmoduleQtDownload/${IMMQT_P}.diff.gz )"

LICENSE="QPL-1.0 | GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="cups debug doc firebird gif icc ipv6 mysql nas odbc opengl postgres sqlite xinerama zlib immqt immqt-bc"

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

# old immodules may cause segfaults on some qt applications,
# especially qtconfig
PDEPEND="!<app-i18n/scim-qtimm-0.7
	!<app-i18n/uim-qt-0.1.7
	!>=app-i18n/uim-qt-0.1.9"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV}

QTBASE=/usr/qt/3
export QTDIR=${S}
export PLATFORM=linux-g++

pkg_setup() {
	if use immqt ; then
		ewarn
		ewarn "You are going to compile binary imcompatible immodule for Qt. This means"
		ewarn "you have to recompile everything depending on Qt after you install it."
		ewarn "Be aware."
		ewarn
	fi
}

src_unpack() {
	unpack ${A}

	export QTDIR=${S}
	cd ${S}

	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure

	epatch ${FILESDIR}/qt-no-rpath-uic.patch

	if use immqt || use immqt-bc ; then
		epatch ../${IMMQT_P}.diff
		epatch ${FILESDIR}/qt-3.3.3-immodule-20040819-event-inversion-20040908.diff

		epatch ${FILESDIR}/qt-3.3.3-immodule-r123-event-inversion-20040909.diff
		sh make-symlinks.sh || die "make symlinks failed"
	fi

#	use icc && export PLATFORM=linux-icc
}

src_compile() {
	export QTDIR=${S}
	export SYSCONF=${D}${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "$HOME/.qt"

	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/$(get_libdir)/mysql" || myconf="${myconf} -no-sql-mysql"
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
	use immqt-bc	&& myconf="${myconf} -im"
	use immqt	&& myconf="${myconf} -im -im-ext"

	export YACC='byacc -d'

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -lpthread -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${QTBASE} -fast ${myconf} \
		-dlopen-opengl || die

	export QTDIR=${S}

	emake src-qmake src-moc sub-src || die
	LD_LIBRARY_PATH="${S}/$(get_libdir):${LD_LIBRARY_PATH}" emake sub-tools || die
}

src_install() {
	# needed to fix lib64 issues on amd64, see bug #45669
	# It would be better to have lib -> lib64, but other libs might be
	# installed in ${QTBASE}/lib which is not currently a symlink...
	if use amd64; then
		dodir ${QTBASE}/lib
		dosym lib ${QTBASE}/lib64
	fi

	export QTDIR=${S}

	# binaries
	into $QTBASE
	dobin bin/*

	# libraries

	dolib lib/libqt-mt.so.3.3.3 lib/libqui.so.1.0.0
	dolib lib/lib{editor,qassistantclient,designercore}.a lib/libqt-mt.la

	cd ${D}/$QTBASE/$(get_libdir)
	for x in libqui.so ; do
		ln -s $x.1.0.0 $x.1.0
		ln -s $x.1.0 $x.1
		ln -s $x.1 $x
	done

	# version symlinks - 3.3.3->3.3->3->.so
	ln -s libqt-mt.so.3.3.3 libqt-mt.so.3.3
	ln -s libqt-mt.so.3.3 libqt-mt.so.3
	ln -s libqt-mt.so.3 libqt-mt.so

	# libqt -> libqt-mt symlinks
	ln -s libqt-mt.so.3.3.3 libqt.so.3.3.3
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

	dodir ${QTBASE}/etc
	keepdir ${QTBASE}/etc/settings

	dodir ${QTBASE}/doc

	if use doc; then
		cp -r ${S}/doc ${D}/${QTBASE}

		cd ${S}/examples
		find . -name Makefile | while read MAKEFILE
		do
			cp ${MAKEFILE} ${MAKEFILE}.old
			sed -e 's:${S}:${QTBASE}:g' ${MAKEFILE}.old > ${MAKEFILE}
			rm -f ${MAKEFILE}.old
		done

		cp -r ${S}/examples ${D}/${QTBASE}

		cd ${S}/tutorial
		find . -name Makefile | while read MAKEFILE
		do
			cp ${MAKEFILE} ${MAKEFILE}.old
			sed -e 's:${S}:${QTBASE}:g' ${MAKEFILE}.old > ${MAKEFILE}
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

	# plugins
	cd ${S}
	plugins=`find plugins -name "lib*.so" -print`
	for x in $plugins; do
		insinto ${QTBASE}/`dirname $x`
		doins $x
	done
}
