# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.1.2-r1.ebuild,v 1.1 2003/04/12 23:20:25 brain Exp $

inherit eutils

IUSE="cups nas postgres opengl mysql odbc gif"

S=${WORKDIR}/qt-x11-free-${PV}

DESCRIPTION="QT version ${PV}"
SLOT="3"
LICENSE="QPL-1.0"

# WARNING: do not give this ebuild keywords that >=kdelibs-3.1.1, >=kdebase-3.1.1-r1 don't have
KEYWORDS="~x86 ~ppc ~sparc" # alpha removed temporarily as I wasn't sure about the special
# alpha stuff in src_unpack

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-free-${PV}.tar.bz2"

HOMEPAGE="http://www.trolltech.com/"

DEPEND="virtual/x11
	media-libs/libpng
	media-libs/lcms
	media-libs/jpeg
	>=media-libs/libmng-1.0.0
	>=media-libs/freetype-2
	virtual/xft
	nas? ( >=media-libs/nas-1.4.1 )
	odbc? ( >=dev-db/unixODBC-2.0 )
	mysql? ( >=dev-db/mysql-3.2.10 )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( >=dev-db/postgresql-7.2 )
	!=kde-base/kdelibs-3.1
	!=kde-base/kdelibs-3.1-r1
	!=kde-base/kdelibs-3.1-r2
	!=kde-base/kdelibs-3.1-r3
	!=kde-base/kdebase-3.1
	!=kde-base/kdebase-3.1-r1
	!=kde-base/kdebase-3.1.1"
# WARNING: the versions blocked above are known to be buggy. DO NOT use them with this qt	

RDEPEND="$DEPEND
	doc? ( ~app-doc/qt-docs-$PV )"
	
QTBASE=/usr/qt/3
export QTDIR=${S}

src_unpack() {

	export QTDIR=${S}

	unpack ${A}

	cd ${S}
	
	epatch ${FILESDIR}/designer.diff
	epatch ${FILESDIR}/${P}-qmlined.diff
	epatch ${FILESDIR}/qsocket-3.1.2.diff
	
	cp configure configure.orig
	sed -e 's:read acceptance:acceptance=yes:' configure.orig > configure
	
	cd mkspecs/linux-g++
	# use env's $CC, $CXX
	if [ -n "$CXX" ]; then
	    einfo 'Using environment definition of $CXX'
	    cp qmake.conf qmake.conf.orig
	    sed -e "s:= g++:= ${CXX}:" qmake.conf.orig > qmake.conf
	fi
	if [ -n "$CC" ]; then
	    einfo 'Using environment definition of $CC'
	    cp qmake.conf qmake.conf.orig
	    sed -e "s:= gcc:= ${CC}:" qmake.conf.orig > qmake.conf
	fi
	
	# hppa and alpha people, please review the following
	
	# hppa need some additional flags
	if [ "${ARCH}" = "hppa" ]; then
		echo "QMAKE_CFLAGS += -fPIC -ffunction-sections" >> qmake.conf
		echo "QMAKE_CXXFLAGS += -fPIC -ffunction-sections" >> qmake.conf
		echo "QMAKE_LFLAGS += -ffunction-sections -Wl,--stub-group-size=25000" >> qmake.conf
	fi
	
	# on alpha we need to compile everything with -fPIC
	if [ ${ARCH} == "alpha" ]; then
	    cp qmake.conf qmake.conf.orig
	    sed -e "s:= -O2:= -O2 -fPIC:" qmake.conf.orig > qmake.conf
	    cat >> ${S}/tools/designer/editor/editor.pro <<_EOF_
QMAKE_CFLAGS += -fPIC
QMAKE_CXXFLAGS += -fPIC
_EOF_
	fi


}

src_compile() {
    
	# fix #11144; qt wants to create lock files etc. in that directory
	[ -d "$QTBASE/etc/settings" ] && addwrite "$QTBASE/etc/settings"

	export QTDIR=${S}
	
	export LDFLAGS="-ldl"

	use cups || myconf="${myconf} -no-cups"
	use nas		&& myconf="${myconf} -system-nas-sound"
	use gif		&& myconf="${myconf} -qt-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/lib/mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server"
	use odbc	&& myconf="${myconf} -plugin-sql-odbc"
	use opengl	&& myconf="${myconf} -enable-module=opengl" || myconf="${myconf} -disable-opengl"
	[ -n "$DEBUG" ]	&& myconf="${myconf} -debug" 		|| myconf="${myconf} -release -no-g++-exceptions"
	
	# avoid wasting time building things we won't install
	rm -rf tutorial examples

	export YACC='byacc -d'
	
	./configure -sm -thread -stl -system-zlib -system-libjpeg -verbose \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -ldl -lpthread -xft -platform linux-g++ -xplatform \
		linux-g++ -xrender -prefix ${QTBASE} -fast ${myconf} || die

	export QTDIR=${S}

	emake src-qmake src-moc sub-src sub-tools || die

}

src_install() {

	export QTDIR=${S}

	cd ${S}

	# binaries
	into $QTBASE
	dobin bin/*

	# libraries
	dolib lib/libqt-mt.so.3.1.2 lib/libqui.so.1.0.0 lib/lib{editor,qassistantclient,designer}.a
	cd ${D}$QTBASE/lib
	for x in libqui.so
	do
	    ln -s $x.1.0.0 $x.1.0
	    ln -s $x.1.0 $x.1
	    ln -s $x.1 $x
	done
	
	# version symlinks - 3.1.2->3.1->3->.so
	ln -s libqt-mt.so.3.1.2 libqt-mt.so.3.1
	ln -s libqt-mt.so.3.1 libqt-mt.so.3
	ln -s libqt-mt.so.3 libqt-mt.so

	# libqt -> libqt-mt symlinks
	ln -s libqt-mt.so.3.1.2 	libqt.so.3.1.2
	ln -s libqt-mt.so.3.1		libqt.so.3.1
	ln -s libqt-mt.so.3		libqt.so.3
	ln -s libqt-mt.so		libqt.so

	# includes
	cd ${S}
	dodir ${QTBASE}/include/private
	cp include/* ${D}/${QTBASE}/include/
	cp include/private/* ${D}/${QTBASE}/include/private/

	# misc
	insinto /etc/env.d
	doins ${FILESDIR}/{45qt3,50qtdir3}

	# misc build reqs
	dodir ${QTBASE}/mkspecs
	cp -R ${S}/mkspecs/linux-g++ ${D}/${QTBASE}/mkspecs/

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
pkg_postinst() {

    ewarn "If you upgraded from QT 3.0.x to 3.1.x, you should remerge any copies"
    ewarn "of kdelibs you have installed. Otherwise, other kde packages may not"
    ewarn "compile properly. If you upgraded QT from 3.0.x to 3.1.x in the past"
    ewarn "but have not remerged kdelib, since then, you should proobably do so now."

}
