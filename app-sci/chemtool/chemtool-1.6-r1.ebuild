# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/chemtool/chemtool-1.6-r1.ebuild,v 1.2 2004/03/15 13:34:13 phosphan Exp $

[ -n "`use kde`" ] && inherit kde-functions
inherit eutils

DESCRIPTION="program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome kde nls"

DEPEND=">=media-gfx/transfig-3.2.3d
	=x11-libs/gtk+-1*
	>=media-libs/libemf-1.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	local mykdedir="${KDEDIR}"
	if [ -z "${mykdedir}" ]; then mykdedir="bogus_kde"; fi
	local config_opts
	config_opts="--enable-emf"

	if [ "`use kde`" ]; then
		config_opts="${config_opts} --with-kdedir=${mykdedir}" ;
	else
		config_opts="${config_opts} --without-kdedir"
	fi

	if [ "`use gnome`" ] ; then
		config_opts="${config_opts} --with-gnomedir=/usr" ;
	else
		config_opts="${config_opts} --without-gnomedir" ;
	fi

	econf ${config_opts} \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {

	local mykdedir="${KDEDIR}"
	if [ -z "${mykdedir}" ]; then mykdedir="bogus_kde"; fi
	local sharedirs="applnk/Graphics mimelnk/application icons/hicolor/32x32/mimetypes"
	for dir in ${sharedirs}; do
		dodir ${mykdedir}/share/${dir}
	done
	dodir /usr/share/mime-types
	dodir /usr/share/pixmaps/mc

	make DESTDIR="${D}" install || die "make install failed"

	if ! use kde; then
			rm -rf ${D}/${mykdedir}
	fi

	if ! use gnome; then
		rm -rf ${D}/usr/share/pixmaps ${D}/usr/share/mime-types
	fi

	dodoc ChangeLog INSTALL README TODO
	insinto /usr/share/${PN}/examples
	doins ${S}/examples/*
	if ! use nls; then rm -rf ${D}/usr/share/locale; fi
}
