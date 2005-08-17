# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers-extra/ati-drivers-extra-8.16.20.ebuild,v 1.1 2005/08/17 22:41:38 lu_zero Exp $

IUSE="qt"

inherit eutils rpm linux-info linux-mod

DESCRIPTION="Ati precompiled drivers extra application"
HOMEPAGE="http://www.ati.com"
SRC_URI="x86? ( http://www2.ati.com/drivers/linux/fglrx_6_8_0-${PV}-1.i386.rpm )
		amd64?
		( http://www2.ati.com/drivers/linux/64bit/fglrx64_6_8_0-${PV}-1.x86_64.rpm )"

LICENSE="ATI GPL-2 QPL-1.0"
KEYWORDS="~amd64 ~x86"  # (~amd64 yet to be fixed)(see bug 95684)

DEPEND="=media-video/ati-drivers-${PV}*
	qt? ( >=x11-libs/qt-3.0 )"

ATIBIN="${D}/opt/ati/bin"
RESTRICT="nostrip"

src_unpack() {
	local OLDBIN="/usr/X11R6/bin"

	cd ${WORKDIR}
	rpm_src_unpack

	mkdir -p ${WORKDIR}/extra
	einfo "Unpacking fglrx_sample_source.tgz..."
	tar --no-same-owner -C ${WORKDIR}/extra/ -zxf \
		${WORKDIR}/usr/src/ATI/fglrx_sample_source.tgz \
		|| die "Failed to unpack fglrx_sample_source.tgz!"
	# Defining USE_GLU allows this to compile with NVIDIA headers just fine
	sed -e "s:-I/usr/X11R6/include:-D USE_GLU -I/usr/X11R6/include:" \
		-i ${WORKDIR}/extra/fgl_glxgears/Makefile.Linux || die

	mkdir -p ${WORKDIR}/extra/fglrx_panel
	einfo "Unpacking fglrx_panel_sources.tgz..."
	tar --no-same-owner -C ${WORKDIR}/extra/fglrx_panel/ -zxf \
		${WORKDIR}/usr/src/ATI/fglrx_panel_sources.tgz \
		|| die "Failed to unpack fglrx_panel_sources.tgz!"
	cd ${WORKDIR}/extra/fglrx_panel
	epatch ${FILESDIR}/ati-drivers-extra-8.14.13-improvements.patch.bz2
	sed -e "s:"${OLDBIN}":"${ATIBIN}":"\
		-i ${WORKDIR}/extra/fglrx_panel/Makefile

	}

src_compile() {
	einfo "Building the fgl_glxgears sample..."
	cd ${WORKDIR}/extra/fgl_glxgears
	make -f Makefile.Linux || ewarn "fgl_glxgears sample not build!"

	if use qt
	then
		einfo "Building the QT fglx panel..."
		cd ${WORKDIR}/extra/fglrx_panel
		emake || die
	fi

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/X11R6/bin/{*.bz2,fgl_glxgears}
}

src_install() {
	local ATI_ROOT="/usr/lib/opengl/ati"

	# Apps
	exeinto /opt/ati/bin
	doexe ${WORKDIR}/extra/fgl_glxgears/fgl_glxgears
	rm -f ${WORKDIR}/usr/X11R6/bin/*

	if use qt
	then
		doexe ${WORKDIR}/extra/fglrx_panel/fireglcontrol

		insinto /usr/share/applications/
		doins ${FILESDIR}/fireglcontrol.desktop

		insinto /usr/share/pixmaps/
		doins ${WORKDIR}/extra/fglrx_panel/ati.xpm
	else
		# Removing unused stuff
		rm -rf ${WORKDIR}/usr/share/{applnk,gnome,icons,pixmaps}
	fi

	# not necessary dodoc ${WORKDIR}/usr/share/doc/fglrx/LICENSE.*

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/{src,share/doc}
}
