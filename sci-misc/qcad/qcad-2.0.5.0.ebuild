# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/qcad/qcad-2.0.5.0.ebuild,v 1.7 2008/11/26 16:42:32 ranger Exp $

inherit kde-functions eutils

MY_P=${P}-1-community.src
PATCH_V="2.0.4.0-1.src"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A 2D CAD package based upon Qt."
SRC_URI="http://www.ribbonsoft.com/archives/qcad/${MY_P}.tar.gz
		doc? ( mirror://gentoo/qcad-manual-200404.tar.bz2 )"
HOMEPAGE="http://www.ribbonsoft.com/qcad.html"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
KEYWORDS="amd64 hppa ppc ppc64 x86"

DEPEND=">=sys-apps/sed-4"
need-qt 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-${PATCH_V}-gentoo.patch
	epatch "${FILESDIR}"/${P}-doc.patch
	epatch "${FILESDIR}"/${PN}-${PATCH_V}-intptr.patch
	epatch "${FILESDIR}"/${PN}-2.0.4.0-gcc43.patch

	for file in */Makefile scripts/build_qcad.sh; do
		sed -i -e 's~qmake~${QTDIR}/bin/qmake~g' $file || \
			die "unable to correct path to qmake in $file"
	done

	cd "${S}"/mkspecs
	echo >> defs.pro "DEFINES += _REENTRANT QT_THREAD_SUPPORT"
	echo >> defs.pro "CONFIG += thread release"
	echo >> defs.pro "QMAKE_CFLAGS_RELEASE += ${CFLAGS}"
	echo >> defs.pro "QMAKE_CXXFLAGS_RELEASE += ${CXXFLAGS}"

	# code does not compile with -pedantic
	sed -i -e "s:-pedantic::" defs.pro \
		|| die "failed to remove -pedantic flag"

	cd "${S}"/scripts
	sed -i -e 's/^make/make ${MAKEOPTS}/' build_qcad.sh || \
		die "unable to add MAKEOPTS"
	sed -i -e 's/^\.\/configure/.\/configure --host=${CHOST}/' build_qcad.sh \
		|| die "unable to set CHOST"
	cd "${S}"/qcad/src
	sed -i -e "s:FULLASSISTANTPATH:${QTDIR}/bin:" qc_applicationwindow.cpp \
		|| die "sed failed on assistant path"
	sed -i -e "s:QCADDOCPATH:/usr/share/doc/${PF}:" \
		qc_applicationwindow.cpp  || die "sed failed on manual path"
}

src_compile() {
	### borrowed from kde.eclass #
	#
	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build process
	# can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p "${T}"/fakehome/.kde
	mkdir -p "${T}"/fakehome/.qt
	export HOME="$T/fakehome"
	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"
	cd scripts
	sh build_qcad.sh || die "build failed"
	if ! test -f "${S}"/qcad/qcad; then
		die "no binary created, build failed"
	fi
}

src_install () {
	cd qcad
	dodoc README || die "Failed to install docs"
	mv qcad qcad.bin || die "Failed to rename qcad binary"
	dobin qcad.bin || die "Failed to install qcad binary"
	echo -e "#!/bin/sh\ncd /usr/share/${P}\nqcad.bin" > qcad \
		|| die "Failed to create qcad wrapper script"
	dobin qcad || die "Failed to install qcad wrapper"

	insinto /usr/share/${P}
	doins -r patterns fonts qm  \
		|| die "Failed to install support files"

	doicon src/xpm/${PN}.xpm
	make_desktop_entry ${PN} QCad ${PN} Office

	if use doc; then
		cd "${WORKDIR}"
		insinto /usr/share/doc/${PF}/
		doins -r qcaddoc.adp cad || die "Failed to install manual"
	fi
}
