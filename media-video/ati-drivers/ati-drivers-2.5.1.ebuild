# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers/ati-drivers-2.5.1.ebuild,v 1.8 2003/09/07 00:08:12 msterret Exp $

IUSE="qt kde gnome"

SRC_URI="http://pdownload.mii.instacontent.net/ati/drivers/fglrx-glc22-4.2.0-${PV}.i586.rpm"
HOMEPAGE="http://www.ati.com"
DESCRIPTION="Ati precompiled drivers for r300, r250 and r200 chipsets"

LICENSE="ATI GPL-2 QPL-1.0"
SLOT="${KV}"
KEYWORDS="-* x86"

DEPEND=">=virtual/linux-sources-2.4
	>=sys-libs/glibc-2.2.2
	app-arch/rpm2targz
	qt? ( >=x11-libs/qt-3.0 )"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
    cd ${WORKDIR}
    rpm2targz ${DISTDIR}/${A}
	tar zxf fglrx-glc22-4.2.0-${PV}.i586.tar.gz
}

src_compile() {
    einfo "building the glx module"

    cd ${WORKDIR}/lib/modules/fglrx/build_mod
    ./make.sh

    einfo "building the fgl_glxgears sample"

    mkdir ${WORKDIR}/fglrxgears
    cd ${WORKDIR}/fglrxgears
    tar -xzvf ${WORKDIR}/usr/src/fglrx_sample_source.tgz
    mv xc/programs/fgl_glxgears/* .
    make -f Makefile.Linux || die

    if [ "`use qt`" ]
	then
	    einfo "building the qt fglx panel"
	    cd ${WORKDIR}
	    local OLDBIN="/usr/X11R6/bin"
	    local ATIBIN="${D}/opt/ati/bin"
	    mkdir fglrx_panel
	    cd  fglrx_panel
	    tar -xzvf ${WORKDIR}/usr/src/fglrx_panel_sources.tgz
	    sed -e "s:"${OLDBIN}":"${ATIBIN}":"\
		Makefile >Makefile.new
		mv Makefile.new Makefile
	emake || die
    fi

#removing stuff
    einfo "cleaning"
    cd ${WORKDIR}
    rm -fR usr/share
    cd usr/X11R6/
    rm -fR bin/firegl*.bz2 bin/LICENSE.* bin/fgl_glxgears src
}

pkg_preinst() {
# clean the dinamic libGL stuff's home to ensure
# we dont have stale libs floating around
    if [ -d ${ROOT}/usr/lib/opengl/ati ]
	then
	    rm -rf ${ROOT}/usr/lib/opengl/ati/*
    fi
}

src_install() {
    local ATI_ROOT="/usr/lib/opengl/ati"

    cd ${WORKDIR}

#drm module
    insinto /lib/modules/${KV}/video
    doins lib/modules/fglrx/build_mod/fglrx.o

#dri driver
    exeinto ${ATI_ROOT}/lib
    doexe usr/X11R6/lib/libGL.so.1.2
    dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so.1
    dosym libGL.so.1.2 ${ATI_ROOT}/lib/libGL.so
    dosym libGL.so.1.2 ${ATI_ROOT}/lib/libMesaGL.so
    #that is the same as in the xfree
    dosym ../xfree/lib/libGL.la ${ATI_ROOT}/lib/libGL.la

#same as in xfree
    exeinto ${ATI_ROOT}/
    dosym ../xfree/include ${ATI_ROOT}/include
    dosym ../xfree/extensions ${ATI_ROOT}/extensions
    rm usr/X11R6/lib/libGL.so.1.2

#apps
    insinto /etc/env.d
    doins ${FILESDIR}/09ati
    exeinto /opt/ati/bin
    doexe fglrxgears/fgl_glxgears
    doexe usr/X11R6/bin/*
    rm usr/X11R6/bin/*

    if [ "`use qt`" ]
	then
	    doexe fglrx_panel/fireglcontrol
    fi

    #if ["`use kde`"] then


    #if ["`use gnome`"]
	cp -R usr ${D}
}

pkg_postinst() {
#switch to the ati implementation
    if [ "${ROOT}" = "/" ]
	then
	    /usr/sbin/opengl-update ati
    fi

    einfo
    einfo "To use the xfree GLX, run \"opengl-update xfree\""
    einfo
    einfo
    einfo "To chance your XF86Config you can use the bundled \"fglrxconfig\""
    einfo

#drm-module
    update-modules
}
