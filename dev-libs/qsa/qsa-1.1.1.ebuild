# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qsa/qsa-1.1.1.ebuild,v 1.8 2006/12/14 23:01:24 mabi Exp $

inherit eutils qt3

S="${WORKDIR}/${PN}-x11-free-${PV}"

DESCRIPTION="Qt Script for Applications, a ECMAScript based scripting toolkit for making customizable Qt/C++ applications."
SRC_URI="ftp://ftp.trolltech.com/qsa/source/${PN}-x11-free-${PV}.tar.gz"
HOMEPAGE="http://www.trolltech.com/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples ide threads"
DEPEND="$(qt_min_version 3.2)"

src_compile() {
	local myconf="-prefix ${D}${QTDIR}"

	use threads && myconf="${myconf} -thread"

	if ! use ide; then
		myconf="${myconf} -no-ide"
		epatch ${FILESDIR}/${P}-without-examples-using-ide.diff
	fi

	if use examples; then
		epatch ${FILESDIR}/${P}-with-examples.diff
		epatch ${FILESDIR}/${P}-example-enums.pro.diff
	else
		epatch ${FILESDIR}/${P}-without-examples.diff
	fi

	epatch ${FILESDIR}/${P}-sandbox-fix.diff

	./configure ${myconf} || die
	emake || die
}

src_install() {
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

	#documentation
	if use doc; then
		dohtml -A dcf -r doc/html/*
	fi

	#examples
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	dodoc README changes-1.1.1
}

pkg_postinst(){
	if use doc && [ "${ROOT}" = "/" ]; then
		#include QSA Documentation content file into assistant
		assistant -addContentFile /usr/share/doc/${PF}/html/qsa.dcf
		assistant -addContentFile /usr/share/doc/${PF}/html/extensions.dcf
		assistant -addContentFile /usr/share/doc/${PF}/html/language.dcf
		assistant -addContentFile /usr/share/doc/${PF}/html/qtscripter.dcf
		assistant -addContentFile /usr/share/doc/${PF}/html/qt-script-for-applications.dcf
	fi
}

pkg_prerm(){
	if use doc && [ "${ROOT}" = "/" ]; then
		#remove QSA Documentation content file into assistant
		assistant -removeContentFile /usr/share/doc/${PF}/html/qsa.dcf
		assistant -removeContentFile /usr/share/doc/${PF}/html/extensions.dcf
		assistant -removeContentFile /usr/share/doc/${PF}/html/language.dcf
		assistant -removeContentFile /usr/share/doc/${PF}/html/qtscripter.dcf
		assistant -removeContentFile /usr/share/doc/${PF}/html/qt-script-for-applications.dcf
	fi
}
