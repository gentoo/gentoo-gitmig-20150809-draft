# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/vmd/vmd-1.8.7-r2.ebuild,v 1.2 2010/08/21 23:10:08 alexxy Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils multilib python toolchain-funcs

DESCRIPTION="Visual Molecular Dynamics"
HOMEPAGE="http://www.ks.uiuc.edu/Research/vmd/"
SRC_URI="${P}.src.tar.gz"

SLOT="0"
LICENSE="vmd"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="msms povray tachyon"

RESTRICT="fetch"

# currently, tk-8.5* with USE=truetype breaks some
# tk apps such as Sequence Viewer or Timeline.
DEPEND="
	|| (
		>=dev-lang/tk-8.5[-truetype]
		=dev-lang/tk-8.4*
	)
	dev-lang/perl
	dev-python/numpy
	sci-biology/stride
	sci-libs/netcdf
	virtual/opengl
	x11-libs/fltk:1.1
	x11-libs/libXft"

RDEPEND="${DEPEND}
	x11-terms/xterm
	msms? ( sci-chemistry/msms )
	povray? ( media-gfx/povray )
	tachyon? ( media-gfx/tachyon )"

VMD_DOWNLOAD="http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD"
# Binary only plugin!!
QA_TEXTRELS="usr/lib*/vmd/plugins/LINUX/tcl/intersurf1.1/bin/intersurf.so"
QA_PRESTRIPPED="usr/lib*/vmd/plugins/LINUX/tcl/intersurf1.1/bin/intersurf.so"
QA_DT_HASH_amd64="usr/lib64/vmd/plugins/LINUX/tcl/intersurf1.1/bin/intersurf.so"
QA_DT_HASH_x86="usr/lib/vmd/plugins/LINUX/tcl/intersurf1.1/bin/intersurf.so"

pkg_nofetch() {
	elog "Please download ${A} from"
	elog "${VMD_DOWNLOAD}"
	elog "after agreeing to the license and then move it to "
	elog "${DISTDIR}"
}

src_prepare() {
	# apply LINUX-arch patches to vmd configure
	cd "${WORKDIR}" && epatch "${FILESDIR}/${P}-gentoo.patch"

	# prepare the plugins
	cd "${WORKDIR}"/plugins

	sed -e "s:CC = gcc:CC = $(tc-getCC):" \
		-e "s:CXX = g++:CXX = $(tc-getCXX):" \
		-e "s:COPTO =.*\":COPTO = -fPIC -o\":" \
		-e "s:LOPTO = .*\":LOPTO = ${LDFLAGS} -fPIC -o\":" \
		-e "s:CCFLAGS =.*\":CCFLAGS = ${CFLAGS}\":" \
		-e "s:CXXFLAGS =.*\":CXXFLAGS = ${CXXFLAGS}\":" \
		-e "s:SHLD = gcc:SHLD = $(tc-getCC):" \
		-e "s:-ltcl8.5:-ltcl:" \
		-i Make-arch || die "Failed to set up plugins Makefile"

	# prepare vmd itself
	cd "${S}"

	# PREFIX
	sed \
		-e "s:/usr/include/:${EPREFIX}/usr/include:g" \
		-i configure || die

	sed -e "s:gentoo-bindir:${ED}/usr/bin:" \
		-e "s:gentoo-libdir:${ED}/usr/$(get_libdir):" \
		-i configure || die "failed to adjust install paths"

	sed -e "s:gentoo-opengl-include:${EPREFIX}/usr/include/GL:" \
		-e "s:gentoo-opengl-libs:${EPREFIX}/usr/$(get_libdir):" \
		-i configure || die "failed to adjust OpenGL paths"

	sed -e "s:gentoo-gcc:$(tc-getCC):" \
		-e "s:gentoo-g++:$(tc-getCXX):" \
		-e "s:gentoo-cflags:${CFLAGS}:" \
		-e "s:gentoo-cxxflags:${CXXFLAGS}:" \
		-e "s:gentoo-ldflags:${LDFLAGS}:g" \
		-i configure || die "Failed to adjust C compiler/flags"

	sed -e "s:gentoo-plugindir:${WORKDIR}/plugins:" \
		-i configure || die "Failed to set up linking to plugin files"

	sed -e "s:gentoo-fltk-include:${EPREFIX}/usr/include/fltk-1.1:" \
		-e "s:gentoo-fltk-libs:${EPREFIX}/usr/$(get_libdir)/fltk-1.1 -Wl,-rpath,${EPREFIX}/usr/$(get_libdir)/fltk-1.1:" \
		-i configure || die "failed setting up fltk"

	sed -e "s:gentoo-netcdf-include:${EPREFIX}/usr/include:" \
		-e "s:gentoo-netcdf-libs:${EPREFIX}/usr/$(get_libdir):" \
		-i configure || die "failed to set up netcdf"

	local NUMPY_INCLUDE="numpy/core/include"
	sed -e "s:gentoo-python-include:${EPREFIX}$(python_get_includedir):" \
		-e "s:gentoo-python-lib:${EPREFIX}$(python_get_libdir):" \
		-e "s:gentoo-python-link:$(PYTHON):" \
		-e "s:gentoo-numpy-include:${EPREFIX}$(python_get_sitedir)/${NUMPY_INCLUDE}:" \
		-i configure || die "failed setting up python"

	sed -e "s:LINUXPPC:LINUX:g" \
		-e "s:LINUXALPHA:LINUX:g" \
		-e "s:LINUXAMD64:LINUX:g" \
		-i "${S}"/bin/vmd.sh || die "failed setting up vmd wrapper script"
}

src_configure() {
	local myconfig="LINUX OPENGL FLTK TK TCL PTHREADS PYTHON IMD NETCDF NUMPY NOSILENT"
	rm -f configure.options && echo $myconfig >> configure.options

	./configure &> /dev/null || die "failed to configure"
}

src_compile() {
	# build plugins
	cd "${WORKDIR}"/plugins

	emake -j1 \
		LINUX TCLINC="-I${EPREFIX}/usr/include" \
		TCLLIB="-L${EPREFIX}/usr/$(get_libdir)" \
		NETCDFLIB="-L${EPREFIX}/usr/$(get_libdir)" \
		NETCDFINC="-I${EPREFIX}/usr/include" \
		NETCDFLDFLAGS="-lnetcdf" \
		|| die "failed to build plugins"

	# build vmd
	cd "${S}"/src
	emake || die "failed to build vmd"
}

src_install() {
	# install plugins
	cd "${WORKDIR}"/plugins
	PLUGINDIR=${ED}/usr/$(get_libdir)/${PN}/plugins make distrib || \
		die "failed to install plugins"

	# install vmd
	cd "${S}"/src
	make install || die "failed to install vmd"

	# export STRIDE_BIN so VMD knows where to find stride
	echo "STRIDE_BIN=${EPREFIX}/usr/bin/stride" > "${T}"/99${PN} || \
		die "Failed to create vmd env file"
	doenvd "${T}"/99${PN} || die "Failed to install vmd env file"

	# install docs
	cd "${S}"
	dodoc Announcement README doc/ig.pdf doc/ug.pdf

	# remove some of the things we don't want and need in
	# /usr/lib
	cd "${ED}"/usr/$(get_libdir)/vmd
	rm -fr doc README Announcement LICENSE || \
		die "failed to clean up /usr/lib/vmd directory"

	# adjust path in vmd wrapper
	sed \
		-e "s:${ED}::" -i "${ED}"/usr/bin/${PN} \
		-e "/^defaultvmddir/s:^.*$:defaultvmddir=\"${EPREFIX}/usr/$(get_libdir)/${PN}\":g" \
		|| die "failed to set up vmd wrapper script"

	# install icon and generate desktop entry
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/vmd.png || die "Failed to install vmd icon"
	insinto /usr/share/applications
	doins "${FILESDIR}"/vmd.desktop || die "Failed to install desktop entry"
}
