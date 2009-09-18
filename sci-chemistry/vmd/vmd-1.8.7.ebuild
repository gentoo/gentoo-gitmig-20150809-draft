# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/vmd/vmd-1.8.7.ebuild,v 1.5 2009/09/18 14:32:58 betelgeuse Exp $

EAPI="2"

inherit eutils toolchain-funcs python

DESCRIPTION="Visual Molecular Dynamics"
LICENSE="vmd"
HOMEPAGE="http://www.ks.uiuc.edu/Research/vmd/"
SRC_URI="${P}.src.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RESTRICT="fetch"

# currently, tk-8.5* with USE=truetype breaks some
# tk apps such as Sequence Viewer or Timeline.
DEPEND="x11-libs/libXft
	virtual/opengl
	x11-libs/fltk:1.1
	>=dev-lang/tcl-8.4
	|| (
		>=dev-lang/tk-8.5[-truetype]
		=dev-lang/tk-8.4*
	)
	=dev-lang/python-2*
	dev-lang/perl
	dev-python/numpy
	sci-biology/stride
	sci-libs/netcdf"

RDEPEND="${DEPEND}
	x11-terms/xterm"

VMD_DOWNLOAD="http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD"

pkg_nofetch() {
	echo
	elog "Please download ${SRC_URI} from"
	elog "${VMD_DOWNLOAD}"
	elog "after agreeing to the license and then move it to "
	elog "${DISTDIR}"
	echo
}

src_prepare() {
	# apply LINUX-arch patches to vmd configure
	epatch "${FILESDIR}/${P}-config.patch"
	epatch "${FILESDIR}/${P}-use-bash-startup.patch"

	# prepare the plugins
	cd "${WORKDIR}"/plugins

	sed -e "s:CC = gcc:CC = $(tc-getCC):" \
		-e "s:CXX = g++:CXX = $(tc-getCXX):" \
		-e "s:COPTO =.*\":COPTO = -fPIC -o\":" \
		-e "s:LOPTO = .*\":LOPTO = -fPIC -o\":" \
		-e "s:CCFLAGS =.*\":CCFLAGS = ${CFLAGS}\":" \
		-e "s:CXXFLAGS =.*\":CXXFLAGS = ${CXXFLAGS}\":" \
		-e "s:SHLD = gcc:SHLD = $(tc-getCC):" \
		-e "s:-ltcl8.5:-ltcl:" \
		-i Make-arch || die "Failed to set up plugins Makefile"

	# prepare vmd itself
	cd "${S}"

	sed -e "s:gentoo-bindir:${D}/usr/bin:" \
		-e "s:gentoo-libdir:${D}/usr/$(get_libdir):" \
		-i configure || die "failed to adjust install paths"

	sed -e "s:gentoo-opengl-include:/usr/include/GL:" \
		-e "s:gentoo-opengl-libs:/usr/$(get_libdir):" \
		-i configure || die "failed to adjust OpenGL paths"

	sed -e "s:gentoo-gcc:$(tc-getCC):" \
		-e "s:gentoo-g++:$(tc-getCXX):" \
		-e "s:gentoo-cflags:${CFLAGS}:" \
		-i configure || die "Failed to adjust C compiler/flags"

	sed -e "s:gentoo-plugindir:${WORKDIR}/plugins:" \
		-i configure || die "Failed to set up linking to plugin files"

	sed -e "s:gentoo-fltk-include:/usr/include/fltk-1.1:" \
		-e "s:gentoo-fltk-libs:/usr/$(get_libdir)/fltk-1.1:" \
		-i configure || die "failed setting up fltk"

	sed -e "s:gentoo-netcdf-include:/usr/include:" \
		-e "s:gentoo-netcdf-libs:/usr/$(get_libdir):" \
		-i configure || die "failed to set up netcdf"

	# get installed python version
	python_version
	local PY="python${PYVER}"

	local NUMPY_INCLUDE="site-packages/numpy/core/include"
	sed -e "s:gentoo-python-include:/usr/include/${PY}:" \
		-e "s:gentoo-python-lib:/usr/$(get_libdir)/${PY}:" \
		-e "s:gentoo-python-link:${PY}:" \
		-e "s:gentoo-numpy-include:/usr/$(get_libdir)/${PY}/${NUMPY_INCLUDE}:" \
		-i configure || die "failed setting up python"

	sed -e "s:LINUXPPC:LINUX:g" \
		-e "s:LINUXALPHA:LINUX:g" \
		-e "s:LINUXAMD64:LINUX:g" \
		-i "${S}"/bin/vmd.sh || die "failed setting up vmd wrapper script"
}

src_configure() {
	local myconfig="LINUX OPENGL FLTK TK TCL PTHREADS PYTHON IMD NETCDF NUMPY"
	rm -f configure.options && echo $myconfig >> configure.options

	./configure &> /dev/null || die "failed to configure"
}

src_compile() {
	# build plugins
	cd "${WORKDIR}"/plugins

	make LINUX TCLINC="-I/usr/include" \
		TCLLIB="-L/usr/$(get_libdir)" \
		|| die "failed to build plugins"

	# build vmd
	cd "${S}"/src
	emake || die "failed to build vmd"
}

src_install() {
	# install plugins
	cd "${WORKDIR}"/plugins
	PLUGINDIR=${D}/usr/$(get_libdir)/${PN}/plugins make distrib || \
		die "failed to install plugins"

	# install vmd
	cd "${S}"/src
	make install || die "failed to install vmd"

	# export STRIDE_BIN so VMD knows where to find stride
	echo "STRIDE_BIN=/usr/bin/stride" > "${T}"/99${PN} || \
		die "Failed to create vmd env file"
	doenvd "${T}"/99${PN} || die "Failed to install vmd env file"

	# install docs
	cd "${S}"
	dodoc Announcement README doc/ig.pdf doc/ug.pdf

	# remove some of the things we don't want and need in
	# /usr/lib
	cd "${D}"/usr/$(get_libdir)/vmd
	rm -fr doc README Announcement LICENSE || \
		die "failed to clean up /usr/lib/vmd directory"

	# adjust path in vmd wrapper
	sed -e "s:${D}::" -i "${D}"/usr/bin/${PN} \
		|| die "failed to set up vmd wrapper script"

	# install icon and generate desktop entry
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/vmd.png || die "Failed to install vmd icon"
	insinto /usr/share/applications
	doins "${FILESDIR}"/vmd.desktop || die "Failed to install desktop entry"
}
