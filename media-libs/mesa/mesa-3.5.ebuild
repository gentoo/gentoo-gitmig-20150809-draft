# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-3.5.ebuild,v 1.11 2004/03/19 07:56:04 mr_bones_ Exp $

IUSE="mmx fbcon sse X svga ggi 3dnow"

MY_P=Mesa-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenGL like graphic library for Linux"
SRC_URI="http://download.sourceforge.net/mesa3d/MesaLib-${PV}.tar.bz2
	 http://download.sourceforge.net/mesa3d/MesaDemos-${PV}.tar.bz2"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	svga? ( >=media-libs/svgalib-1.4.2-r1 )"

if [ "`use X`" ]
then
	PROVIDE="virtual/opengl virtual/glu virtual/glut"
else
	PROVIDE="virtual/opengl"
fi

SLOT="3.5"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc ~alpha"

src_compile() {
	local myconf

	use mmx \
		&& myconf="--enable-mmx" \
		|| myconf="--disable-mmx"

	use 3dnow \
		&& myconf="${myconf} --enable-3dnow" \
		|| myconf="${myconf} --disable-3dnow"

	use sse \
		&& myconf="${myconf} --enable-sse" \
		|| myconf="${myconf} --disable-sse"

	use X && ( \
		myconf="${myconf} --with-x --without-glut"
		# --without-glut means that mesa is forced to use and install
		# his own version of glut.
	) || ( \
		myconf="${myconf} --without-x"
		rm -rf src-glut
	)

	( use ggi && use fbcon ) \
		|| myconf="${myconf} --disable-ggi-fbdev --without-ggi"

	use svga || myconf="${myconf} --without-svga"

	cp configure configure.orig
	sed -e "s:^ggi_confdir.*:ggi_confdir=/etc/ggi:" \
		-e "s:^ggi_libdir.*:ggi_libdir=\$prefix/lib:" \
		configure.orig > configure

	econf \
		--sysconfdir=/etc/mesa \
		${myconf} || die

	( use ggi && use fbcon ) && ( \
		cd ${S}/src/GGI
		cp Makefile Makefile.orig
		sed -e "s:^ggimesaconfdatadir.*:ggimesaconfdatadir = \${ggi_confdir}:" \
			Makefile.orig > Makefile

		cd ${S}/src/GGI/default
		cp stubs.c stubs.c.orig
		sed -e "s:Texture.Enabled:Texture.ReallyEnabled:" stubs.c.orig > stubs.c

		cd ${S}/src/GGI/include/ggi/mesa
		cp display_fbdev.h display_fbdev.h.orig
		sed -e "s:fbdev_hook:ggi_fbdev_priv:" display_fbdev.h.orig > display_fbdev.h

		cd ${S}
		mkdir gg
		ln -s /usr/lib/libgg*.so .
	)

	emake || die

	use ggi && ( \
		cd ${S}/ggi/ggiglut
		make \
			libglut_la_LIBADD="-lggi -lgg -L${S}/src/.libs -lGL" || die
	)
}

src_install () {
	use ggi && ( \
		cd ggi/ggiglut
		make DESTDIR=${D} install || die
		cd ${D}/usr/lib
		cp libglut.la libglut.orig
		sed -e "s:-L${S}/src/.libs::g" libglut.orig > libglut.la
		rm libglut.orig
	)

	cd ${S}
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
	#we no longer install demos since they seem to be linked 
	# for built-time testing only.
}
