# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.1.1.ebuild,v 1.2 2005/02/08 11:51:49 blubb Exp $

inherit eutils kde-functions

S="${WORKDIR}/${PN}-x11-free-${PV}"
DESCRIPTION="QSA version ${PV}, Qt Script for Application is a ECMAScript based language
to provide a scripting engine to applications developped with Qt"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SRC_URI="ftp://ftp.trolltech.com/qsa/source/${PN}-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"
DEPEND=">=x11-libs/qt-3.1.2-r3"
IUSE="threads examples ide doc"

set-qtdir 3.1

src_compile() {
	QSACONFOPT=""

	use thread && QSACONFOPT="-thread"
	! use ide && QSACONFOPT="${QSACONFOPT} -no-ide" && epatch ${FILESDIR}/${P}-without-examples-using-ide.diff
	use examples && einfo "Building QSA with examples" && epatch ${FILESDIR}/${P}-with-examples.diff && epatch ${FILESDIR}/${P}-example-enums.pro.diff || (einfo "Building QSA without examples" && epatch ${FILESDIR}/${P}-without-examples.diff)

	epatch ${FILESDIR}/${P}-sandbox-fix.diff

	einfo "Configure QSA with ${QSACONFOPT} in Root dir: ${QTDIR} (command: ./configure -prefix ${QTDIR} ${QSACONFOPT})"
	./configure -prefix ${D}${QTDIR} ${QSACONFOPT} || die
	emake || die
}

src_install() {

	sed -e "s:${S}:${QTBASE}:g" ${S}/.qmake.cache > ${D}/${QTBASE}/.qmake.cache

	into ${QTDIR}

	#includes
	insinto ${QTDIR}/include
	doins src/qsa/qsaglobal.h
	doins src/qsa/qsconfig.h
	doins src/qsa/qsargument.h
	doins src/qsa/qsproject.h
	doins src/qsa/qsinterpreter.h
	doins src/qsa/qseditor.h
	doins src/qsa/qsutilfactory.h
	doins src/qsa/qswrapperfactory.h
	doins src/qsa/qsobjectfactory.h
	doins src/qsa/qsscript.h
	doins src/qsa/qsinputdialogfactory.h
	doins src/ide/qsworkbench.h


	#QSA mkspec feature
	insinto ${QTDIR}/mkspecs/${QMAKESPEC}
	doins src/qsa/qsa.prf


	#libs
	dolib lib/libqsa.so.1.1.1
	cd ${D}/${QTDIR}/lib
	ln -s libqsa.so.1.1.1 libqsa.so.1.1
	ln -s libqsa.so.1.1 libqsa.so.1
	ln -s libqsa.so.1 libqsa.so
	cd -
	insinto ${QTDIR}/lib
	doins lib/libqsa.prl


	#QSA plugin (SEditor) for Qt designer 
	insinto ${QTDIR}/plugins/designer
	doins plugins/designer/libqseditorplugin.so


	DIR4DOC=/usr/share/doc/${PF}

	#documentation
	if use doc; then
	    dohtml -r doc/html/*
	    insinto ${DIR4DOC}/html
	    doins doc/html/qsa.dcf
	    doins doc/html/extensions.dcf
	    doins doc/html/language.dcf
	    doins doc/html/qtscripter.dcf
	    doins doc/html/qt-script-for-applications.dcf
	fi

	#examples
	if use examples; then
	    cp -R examples ${D}${DIR4DOC}/examples
	fi

	insinto ${DIR4DOC}
	doins INSTALL README LICENSE.GPL changes-1.1.1
}

pkg_postinst(){
	if use doc; then
	    #include QSA Documentation content file into assistant
	    assistant -addContentFile /usr/share/doc/${PF}/html/qsa.dcf
	    assistant -addContentFile /usr/share/doc/${PF}/html/extensions.dcf
	    assistant -addContentFile /usr/share/doc/${PF}/html/language.dcf
	    assistant -addContentFile /usr/share/doc/${PF}/html/qtscripter.dcf
	    assistant -addContentFile /usr/share/doc/${PF}/html/qt-script-for-applications.dcf
	fi
}

pkg_prerm(){
	if use doc; then
	    #remove QSA Documentation content file into assistant
	    assistant -removeContentFile /usr/share/doc/${PF}/html/qsa.dcf
	    assistant -removeContentFile /usr/share/doc/${PF}/html/extensions.dcf
	    assistant -removeContentFile /usr/share/doc/${PF}/html/language.dcf
	    assistant -removeContentFile /usr/share/doc/${PF}/html/qtscripter.dcf
	    assistant -removeContentFile /usr/share/doc/${PF}/html/qt-script-for-applications.dcf
	fi
}
