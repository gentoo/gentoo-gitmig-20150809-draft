# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-drivers-extra/ati-drivers-extra-3.7.6.ebuild,v 1.2 2004/04/10 16:26:20 spyderous Exp $

IUSE="qt kde gnome"

inherit eutils rpm

DESCRIPTION="Ati precompiled drivers extra application"
HOMEPAGE="http://www.ati.com"
SRC_URI="http://www2.ati.com/drivers/linux/fglrx-4.3.0-${PV}.i386.rpm"
SLOT="${KV}"
LICENSE="ATI GPL-2 QPL-1.0"
KEYWORDS="-* ~x86"

DEPEND=">=virtual/linux-sources-2.4
	app-arch/rpm2targz
	~media-video/ati-drivers-${PV}
	qt? ( >=x11-libs/qt-3.0 )"

RDEPEND="=media-video/ati-drivers-${PV}
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
	sed -e "s:"${OLDBIN}":"${ATIBIN}":"\
		-i ${WORKDIR}/extra/fglrx_panel/Makefile

	# Messed up fglrx_panel headers
	cd ${WORKDIR}/extra/fglrx_panel
	epatch ${FILESDIR}/fglrx-3.7.0-fix-fglrx_panel-includes.patch
}

src_compile() {
	einfo "Building the fgl_glxgears sample..."
	cd ${WORKDIR}/extra/fgl_glxgears
	make -f Makefile.Linux || ewarn "fgl_glxgears sample not build!"

	if [ "`use qt`" ]
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

	if [ "`use qt`" ]
	then
		doexe ${WORKDIR}/extra/fglrx_panel/fireglcontrol

		# Fix the paths in these
		sed -e 's|/usr/X11R6/|/opt/ati/|g' \
			-i ${WORKDIR}/usr/share/applnk/fireglcontrol.kdelnk \
			-i ${WORKDIR}/usr/share/gnome/apps/fireglcontrol.desktop
	else
		# Removing unused stuff
		rm -rf ${WORKDIR}/usr/share/{applnk,gnome,icons,pixmaps}
	fi

	dodoc ${WORKDIR}/usr/share/doc/fglrx/LICENSE.*

	# Removing unused stuff
	rm -rf ${WORKDIR}/usr/{src,share/doc}
}
