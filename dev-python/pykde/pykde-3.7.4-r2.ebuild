# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykde/pykde-3.7.4-r2.ebuild,v 1.2 2003/11/10 19:00:37 caleb Exp $

inherit eutils distutils

MAJ_PV=${PV%.[0-9]*}
MIN_PV=${PV##*[0-9].}
MY_PN="PyKDE"
MY_P=${MY_PN}-${MAJ_PV}-${MIN_PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="set of Python bindings for the KDE libs"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyKDE2/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pykde/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=dev-lang/python-2.2.1
	>=dev-python/sip-3.6
	>=dev-python/PyQt-3.6
	>=kde-base/kdelibs-3.0.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug #27401 and 27619
	distutils_python_version
	if [ "${PYVER}" = "2.3" ]; then
		if [ "${KDEDIR}" = "/usr/kde/3" ]; then
			mv ${S}/sip/global.sip  ${S}/sip/global.sip22
			mv ${S}/sip/global.sip23 ${S}/sip/global/sip
		else
			mv ${S}/sip/kzip.sip ${S}/sip/kzip.sip22
			mv ${S}/sip/kzip.sip23 ${S}/sip/kzip.sip
		fi
	fi

	PYQTVER="$(pyuic -version 2>&1 )"
	PYQTVER="${PYQTVER#Python User Interface Compiler }"
	PYQTVER="${PYQTVER% for Qt version *}"
	PYQTVER_MAJOR=${PYQTVER/.*/}
	PYQTVER_MINOR=${PYQTVER#${PYQTVER_MAJOR}.}
	PYQTVER_MINOR=${PYQTVER_MINOR/.*}

	if [ "${PYQTVER_MAJOR}.${PYQTVER_MINOR}" = "3.8" ]; then
		local x="${S}/build.py"
		echo PyQt 3.8 detected.
		echo Running sed on $x
		cp $x ${x}.orig
		sed -e 's/Release    = "3.7"/Release =    "3.8"/' ${x}.orig >${x}
		rm ${x}.orig
	fi
}

src_compile() {
	dodir /usr/lib/python${PYVER}/site-packages
	dodir /usr/include/python${PYVER}
	python build.py \
		-d ${D}/usr/lib/python${PYVER}/site-packages \
		-s /usr/lib/python${PYVER}/site-packages \
		-o ${KDEDIR}/lib \
		-c+ -l qt-mt -v /usr/share/sip/qt || die
	make || die
}

src_install() {
	distutils_python_version

	dodir /usr/lib/python${PYVER}/site-packages
	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS THANKS README NEWS COPYING DETAILS BUGS README.importTest
	dodir /usr/share/doc/${PF}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${PF}/
}
