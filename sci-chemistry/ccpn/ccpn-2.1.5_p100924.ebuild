# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ccpn/ccpn-2.1.5_p100924.ebuild,v 1.1 2010/09/24 06:26:42 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="ssl tk"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit eutils portability python toolchain-funcs versionator

PATCHSET="${PV##*_p}"
MY_PN="${PN}mr"
MY_PV="$(replace_version_separator 3 _ ${PV%%_p*})"
MY_MAJOR="$(get_version_component_range 1-3)"

DESCRIPTION="The Collaborative Computing Project for NMR"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/${MY_PN}/analysis${MY_PV}.tar.gz"
	[[ -n ${PATCHSET} ]] && SRC_URI="${SRC_URI}	http://dev.gentoo.org/~jlec/distfiles/ccpn-update-${PATCHSET}.patch.bz2"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"

SLOT="0"
LICENSE="|| ( CCPN LGPL-2.1 )"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+opengl"

RDEPEND="
	dev-lang/tk[threads]
	>=dev-python/numpy-1.4
	>=dev-tcltk/tix-8.4.3
	=sci-libs/ccpn-data-"${MY_MAJOR}"*
	x11-libs/libXext
	x11-libs/libX11
	opengl? ( media-libs/freeglut )"
DEPEND="${RDEPEND}"

RESTRICT="mirror"
S="${WORKDIR}"/${MY_PN}/${MY_PN}$(get_version_component_range 1-2 ${PV})

src_prepare() {
	[[ -n ${PATCHSET} ]] && \
		epatch "${WORKDIR}"/ccpn-update-${PATCHSET}.patch

	epatch "${FILESDIR}"/${MY_PV}-parallel.patch

	local tk_ver
	local myconf

	tk_ver="$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)"

	if use opengl; then
		GLUT_NEED_INIT="-DNEED_GLUT_INIT"
		IGNORE_GL_FLAG=""
		GL_FLAG="-DUSE_GL_FALSE"
		GL_DIR="${EPREFIX}/usr"
		GL_LIB="-lglut -lGLU -lGL"
		GL_INCLUDE_FLAGS="-I\$(GL_DIR)/include"
		GL_LIB_FLAGS="-L\$(GL_DIR)/$(get_libdir)"

	else
		IGNORE_GL_FLAG="-DIGNORE_GL"
		GL_FLAG="-DUSE_GL_FALSE"
	fi

	GLUT_NOT_IN_GL=""
	GLUT_FLAG="\$(GLUT_NEED_INIT) \$(GLUT_NOT_IN_GL)"

	rm -rf data model doc license || die
	python_copy_sources

	preparation() {
		sed \
			-e "s:/usr:${EPREFIX}/usr:g" \
			-e "s:^\(CC =\).*:\1 $(tc-getCC):g" \
			-e "s:^\(OPT_FLAG =\).*:\1 ${CFLAGS}:g" \
			-e "s:^\(LINK_FLAGS =.*\):\1 ${LDFLAGS}:g" \
			-e "s:^\(IGNORE_GL_FLAG =\).*:\1 ${IGNORE_GL_FLAG}:g" \
			-e "s:^\(GL_FLAG =\).*:\1 ${GL_FLAG}:g" \
			-e "s:^\(GL_DIR =\).*:\1 ${GL_DIR}:g" \
			-e "s:^\(GL_LIB =\).*:\1 ${GL_LIB}:g" \
			-e "s:^\(GL_LIB_FLAGS =\).*:\1 ${GL_LIB_FLAGS}:g" \
			-e "s:^\(GL_INCLUDE_FLAGS =\).*:\1 ${GL_INCLUDE_FLAGS}:g" \
			-e "s:^\(GLUT_NEED_INIT =\).*:\1 ${GLUT_NEED_INIT}:g" \
			-e "s:^\(GLUT_NOT_IN_GL =\).*:\1:g" \
			-e "s:^\(X11_LIB_FLAGS =\).*:\1 -L${EPREFIX}/usr/$(get_libdir):g" \
			-e "s:^\(TCL_LIB_FLAGS =\).*:\1 -L${EPREFIX}/usr/$(get_libdir):g" \
			-e "s:^\(TK_LIB_FLAGS =\).*:\1 -L${EPREFIX}/usr/$(get_libdir):g" \
			-e "s:^\(PYTHON_INCLUDE_FLAGS =\).*:\1 -I\$(PYTHON_DIR)/include/python$(python_get_version):g" \
			-e "s:^\(PYTHON_LIB =\).*:\1 -lpython$(python_get_version):g" \
			c/environment_default.txt > c/environment.txt
	}
	python_execute_function -s preparation
}

src_compile() {
	building() {
		emake -C c all links
	}
	python_execute_function -s building
}

src_install() {
	local libdir
	local tkver

	find . -name "*.pyc" -type d -delete

	libdir=$(get_libdir)
	tkver=$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)

	for wrapper in analysis dangle dataShifter depositionFileImporter extendNmr eci formatConverter pipe2azara; do
		sed -e "s:gentoo_sitedir:${EPREFIX}$(python_get_sitedir -f):g" \
		    -e "s:gentoolibdir:${EPREFIX}/usr/${libdir}:g" \
			-e "s:gentootk:${EPREFIX}/usr/${libdir}/tk${tkver}:g" \
			-e "s:gentootcl:${EPREFIX}/usr/${libdir}/tclk${tkver}:g" \
			-e "s:gentoopython:${EPREFIX}/usr/bin/python:g" \
			-e "s://:/:g" \
		    "${FILESDIR}"/${wrapper} > "${T}"/${wrapper} || die "Fail fix ${wrapper}"
		dobin "${T}"/${wrapper} || die "Failed to install ${wrapper}"
	done

	installation() {
		local in_path
		local files
		local pydocs

		pydocs="$(find python -name doc -type d)"
		rm -rf ${pydocs} || die

		in_path=$(python_get_sitedir)/${PN}

		for i in python/memops/format/compatibility/{Converters,part2/Converters2}.py; do
			sed \
				-e 's:#from __future__:from __future__:g' \
				-i ${i} || die
		done

		insinto ${in_path}

		dodir ${in_path}/c

		ebegin "Installing main files"
			doins -r python || die "main files installation failed"
		eend

		dosym ../../../..//share/doc/ccpn-data-${MY_MAJOR}/html ${in_path}/doc || die
		for i in ${pydocs}; do
			dosym /usr/share/doc/ccpn-data-${MY_MAJOR}/html/${i} ${in_path}/${i}
		done

		dosym /usr/share/ccpn/data ${in_path}/data
		dosym /usr/share/ccpn/model ${in_path}/model

		einfo "Adjusting permissions"

		files="
			ccp/c/StructUtil.so
			ccp/c/StructStructure.so
			ccp/c/StructBond.so
			ccp/c/StructAtom.so
			ccpnmr/c/DyAtomCoord.so
			ccpnmr/c/DyDistConstraint.so
			ccpnmr/c/DyDistForce.so
			ccpnmr/c/AtomCoordList.so
			ccpnmr/c/DyAtomCoordList.so
			ccpnmr/c/ContourStyle.so
			ccpnmr/c/ContourLevels.so
			ccpnmr/c/SliceFile.so
			ccpnmr/c/PeakCluster.so
			ccpnmr/c/Dynamics.so
			ccpnmr/c/Bacus.so
			ccpnmr/c/Midge.so
			ccpnmr/c/DyDistConstraintList.so
			ccpnmr/c/WinPeakList.so
			ccpnmr/c/PeakList.so
			ccpnmr/c/DistConstraint.so
			ccpnmr/c/CloudUtil.so
			ccpnmr/c/DistForce.so
			ccpnmr/c/DistConstraintList.so
			ccpnmr/c/AtomCoord.so
			ccpnmr/c/DyDynamics.so
			ccpnmr/c/ContourFile.so
			memops/c/ShapeFile.so
			memops/c/BlockFile.so
			memops/c/PdfHandler.so
			memops/c/MemCache.so
			memops/c/FitMethod.so
			memops/c/PsHandler.so
			memops/c/GlHandler.so
			memops/c/StoreFile.so
			memops/c/StoreHandler.so
			memops/c/TkHandler.so"

		for FILE in ${files}; do
			fperms 755 ${in_path}/python/${FILE}
		done
	}
	python_execute_function -s installation
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
