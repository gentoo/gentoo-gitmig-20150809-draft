# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.93.0314-r1.ebuild,v 1.1 2003/06/18 00:37:18 george Exp $

IUSE=""

DESCRIPTION="Erlang bindings for the SDL library"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"
HOMEPAGE="http://esdl.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.4
	x11-base/opengl-update"

#openGL state tracking
MY_OpenGL="xfree"

pkg_setup() {
	#check whether we have nvidia opengl active
	if [ -n "`ls -l /usr/lib/libGL.so|grep nvidia`" ]; then
		MY_OpenGL="nvidia"
		einfo "detected nvidia drivers"
		einfo "activating Mesa implementation temporarily"
		opengl-update xfree
	else
		einfo "nvidia openGL is not active"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	#Makefile wants to install some docs that arent' actually there
	epatch ${FILESDIR}/${P}.patch.bz2
}

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	ERLANG_DIR="/usr/lib/erlang/lib/"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	dodir ${ESDL_DIR}

	make install INSTALLDIR=${D}/${ESDL_DIR} || die
	cp include/* ${D}/${ESDL_DIR}/include/ || die
	dosym ${ESDL_DIR} ${ERLANG_DIR}/${PN}
	dodoc Readme license.terms
	mv ${D}/${ESDL_DIR}/doc/ ${D}/usr/share/doc/${PF}/html/
}

pkg_postinst() {
	#now we need to activate proper openGL again
	if [ $MY_OpenGL == "nvidia" ]; then
		opengl-update nvidia
		einfo "activating nvidia drivers"
	fi
}
