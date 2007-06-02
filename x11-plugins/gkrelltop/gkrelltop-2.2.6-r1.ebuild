# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrelltop/gkrelltop-2.2.6-r1.ebuild,v 1.8 2007/06/02 16:55:13 armin76 Exp $

inherit gkrellm-plugin

DESCRIPTION="a GKrellM2 plugin which displays the top three processes"
SRC_URI="http://psychology.rutgers.edu/~zaimi/html/${PN}/${PN}_2.2-6.tar.gz"
HOMEPAGE="http://psychology.rutgers.edu/~zaimi/software.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"

IUSE=""

PLUGIN_SERVER_SO=gkrelltopd.so
PLUGIN_SO=gkrelltop2.so

src_compile() {
	# Unfortunately, the supplied Makefile won't work properly on
	# non-x86, so we have to do this the hard way.
	if built_with_use app-admin/gkrellm X; then
		PKGCFG_ITEM="gtk+-2.0"
	else
		PKGCFG_ITEM="glib-2.0"
	fi
	CONFIG="-DLINUX -DGKRELLM2 -fPIC `pkg-config ${PKGCFG_ITEM} --cflags`"
	LIBS="`pkg-config ${PKGCFG_ITEM} --libs` -shared"
	OBJS="top_three2.o"
	XOBJS="${OBJS} gkrelltop2.o"
	DOBJS="${OBJS} gkrelltopd.o"
	gcc -c $CONFIG $CFLAGS top_three.c -o top_three2.o || die
	if built_with_use app-admin/gkrellm X; then
		gcc -c $CONFIG $CFLAGS gkrelltop.c -o gkrelltop2.o || die
		gcc $LIBS $CONFIG $CFLAGS -o gkrelltop2.so $XOBJS || die
	fi
	gcc -c $CONFIG $CFLAGS gkrelltopd.c -o gkrelltopd.o || die
	gcc $LIBS $CONFIG $CFLAGS -o gkrelltopd.so $DOBJS || die
}

pkg_postinst() {
	einfo "To enable the gkrelltopd server plugin, you must add the following"
	einfo "line to /etc/gkrellmd.conf:"
	einfo "\tplugin-enable gkrelltopd"
}
