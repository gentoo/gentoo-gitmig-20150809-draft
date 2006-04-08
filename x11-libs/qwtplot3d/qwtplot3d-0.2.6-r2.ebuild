# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtplot3d/qwtplot3d-0.2.6-r2.ebuild,v 1.3 2006/04/08 09:19:34 nixnut Exp $

inherit multilib qt3

MY_P=${P/_/-}
S=${WORKDIR}/${PN}

DESCRIPTION="opengl and qt-based 3D widget library for C++"
HOMEPAGE="http://qwtplot3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/qwtplot3d/${MY_P}.tgz
	doc? ( http://qwtplot3d.sourceforge.net/qwtplot3d-doc.zip )"

LICENSE="ZLIB"
SLOT="0"
IUSE="doc examples"
KEYWORDS="amd64 ~ppc ~x86"

DEPEND="$(qt_min_version 3.3)
	>=sys-apps/sed-4
	doc? ( app-arch/unzip )"
RDEPEND="$(qt_min_version 3.3)"

src_unpack () {
	unpack ${A}
	cd ${S}
	find . -type f -name "*.pro" | while read file; do
		sed -e 's/.*no-exceptions.*//g' -i ${file}
		echo >> ${file} "QMAKE_CFLAGS_RELEASE += ${CFLAGS}"
		echo >> ${file} "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}"
	done
	find examples -type f -name "*.pro" | while read file; do
		echo >> ${file} "INCLUDEPATH += ${ROOT}usr/include/qwtplot3d"
	done
}

src_compile () {
	addwrite ${QTDIR}/etc/settings
	${QTDIR}/bin/qmake qwtplot3d.pro || die "qmake failed."
	emake || die "emake failed."
}

src_install () {
	dolib lib/libqwtplot3d.so.${PV} || die "dolib failed."
	# do NOT remove these symlinks, other packages depend on it
	dosym libqwtplot3d.so.${PV} /usr/$(get_libdir)/libqwtplot3d.so
	dosym libqwtplot3d.so.${PV} /usr/$(get_libdir)/libqwtplot3d.so.${PV/.*/}
	chmod -R 644 examples
	chmod 755 examples examples/simpleplot/ examples/mesh2/ \
		examples/enrichments/ examples/axes/ examples/autoswitch/ \
		examples/axes/src/
	mkdir -p ${D}/usr/include/qwtplot3d/
	install include/* ${D}/usr/include/qwtplot3d/
	if use examples; then
		dodir /usr/share/doc/${PF}
		cp -pPR examples ${D}/usr/share/doc/${PF}/
	fi
	use doc && dohtml -r doc/web/doxygen/*
}
