# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-3.5.ebuild,v 1.12 2004/06/07 22:42:53 agriffis Exp $

IUSE="mmx fbcon sse X svga ggi 3dnow"

MY_P=Mesa-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenGL like graphic library for Linux"
SRC_URI="http://download.sourceforge.net/mesa3d/MesaLib-${PV}.tar.bz2
	 http://download.sourceforge.net/mesa3d/MesaDemos-${PV}.tar.bz2"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	svga? ( >=media-libs/svgalib-1.4.2-r1 )
	>=sys-apps/sed-4"

if use X; then
	PROVIDE="virtual/opengl virtual/glu virtual/glut"
else
	PROVIDE="virtual/opengl"
fi

SLOT="3.5"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc ~alpha"

src_compile() {
	local myconf="
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_with svga)"

	if use X ; then
		# --without-glut means that mesa is forced to use and install
		# its own version of glut
		myconf="${myconf} --with-x --without-glut"
	else
		myconf="${myconf} --without-x"
		rm -rf src-glut
	fi

	if ! use ggi || ! use fbcon; then
		myconf="${myconf} --disable-ggi-fbdev --without-ggi"
	fi

	sed -i -e 's:^ggi_confdir.*:ggi_confdir=/etc/ggi:' \
		-e 's:^ggi_libdir.*:ggi_libdir=$prefix/lib:' configure \
		|| die "sed failed"

	econf \
		--sysconfdir=/etc/mesa \
		${myconf} || die

	if use ggi && use fbcon; then
		sed -i -e 's:^ggimesaconfdatadir.*:ggimesaconfdatadir = ${ggi_confdir}:' \
			${S}/src/GGI/Makefile \
			|| die "sed Makefile failed"
		sed -i -e 's:Texture.Enabled:Texture.ReallyEnabled:' \
			${S}/src/GGI/default/stubs.c \
			|| die "sed stubs.c failed"
		sed -i -e 's:fbdev_hook:ggi_fbdev_priv:' \
			${S}/src/GGI/include/ggi/mesa/display_fbdev.h \
			|| die "sed display_fbdev.h failed"

		cd ${S}
		mkdir gg
		ln -s /usr/lib/libgg*.so .
	fi

	emake || die "emake failed"

	if use ggi; then
		make -C ${S}/ggi/ggiglut \
			libglut_la_LIBADD="-lggi -lgg -L${S}/src/.libs -lGL" || die
	fi
}

src_install() {
	if use ggi; then
		cd ggi/ggiglut
		make DESTDIR=${D} install || die
		sed -i -e "s:-L${S}/src/.libs::g" ${D}/usr/lib/libglut.la \
		|| die "sed libglut.la failed"
	fi

	make DESTDIR=${D} install || die
	cd ${D}/usr/lib
	if [ "$PN" = "mesa-glu" ]
	then
		rm -f libGL.*
		rm -f ../include/GL/gl.h
		rm -f ../include/GL/glx.h
		rm -f ../include/GL/osmesa.h
	else
		ln -s libGL.so.2.1.* libMesaGL.so.3
	fi
	ln -s libGLU.so.1.1.* libMesaGLU.so.3

	cd ${S}
	dodoc docs/*

	# we no longer install demos since they seem to be linked 
	# for built-time testing only.
}
