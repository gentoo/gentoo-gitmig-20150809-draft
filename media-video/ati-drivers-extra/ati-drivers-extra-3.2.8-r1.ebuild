# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers-extra/ati-drivers-extra-3.2.8-r1.ebuild,v 1.6 2004/07/14 21:23:36 agriffis Exp $

IUSE="qt"

DESCRIPTION="Ati precompiled drivers extra applications"
HOMEPAGE="http://www.ati.com"
SRC_URI="http://www2.ati.com/drivers/linux/fglrx-glc22-4.3.0-${PV}.i586.rpm"
SLOT="${KV}"
LICENSE="ATI GPL-2 QPL-1.0"
KEYWORDS="-* x86"

DEPEND="app-arch/rpm2targz
	>=x11-base/xfree-4.3.0
	=media-video/ati-drivers-${PV}*
	qt? ( >=x11-libs/qt-3.0 )"

RDEPEND="=media-video/ati-drivers-${PV}*
		qt? ( >=x11-libs/qt-3.0 )"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
	cd ${WORKDIR}
	rpm2targz ${DISTDIR}/${A} ||die
	tar zxf ${WORKDIR}/fglrx-glc22-4.3.0-${PV}.i586.tar.gz || die
	mkdir ${WORKDIR}/fglrxgears
	cd ${WORKDIR}/fglrxgears
	tar zxf ${WORKDIR}/usr/src/ATI/fglrx_sample_source.tgz || die
	mv xc/programs/fgl_glxgears/* .
	cp Makefile.Linux Makefile.Linux.orig || die
	#defining USE_GLU allows this to compile with NVIDIA headers just fine
	sed -e "s:-I/usr/X11R6/include:-D USE_GLU -I/usr/X11R6/include:" Makefile.Linux.orig > Makefile.Linux || die
	cd ${WORKDIR}
	local OLDBIN="/usr/X11R6/bin"
	local ATIBIN="${D}/opt/ati/bin"
	mkdir fglrx_panel
	cd fglrx_panel
	tar zxf ${WORKDIR}/usr/src/ATI/fglrx_panel_sources.tgz || die
	sed -e "s:"${OLDBIN}":"${ATIBIN}":"\
	Makefile >Makefile.new
	mv Makefile.new Makefile
}

pkg_setup(){
	check_KV || die "please ensure /usr/src/linux points to your kernel symlink"
}


src_compile() {
	einfo "building the fgl_glxgears sample"
	cd ${WORKDIR}/fglrxgears
	make -f Makefile.Linux || ewarn "fgl_glxgears sample not build"

	if use qt
	then
	einfo "building the qt fglx panel"
		cd ${WORKDIR}/fglrx_panel
		emake || die
	fi
}


src_install() {
	local ATI_ROOT="/usr/lib/opengl/ati"
	cd ${WORKDIR}
	exeinto /opt/ati/bin
	doexe fglrxgears/fgl_glxgears
	rm usr/X11R6/bin/*

	if use qt
	then
		doexe fglrx_panel/fireglcontrol
	fi
}
