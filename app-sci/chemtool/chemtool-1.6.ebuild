# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/chemtool/chemtool-1.6.ebuild,v 1.2 2003/08/05 18:31:42 vapier Exp $

[ -n "`use kde`" ] && inherit kde-functions
inherit eutils

DESCRIPTION="program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome kde nls"

DEPEND=">=media-gfx/transfig-3.2.3d
	>=x11-libs/gtk+-1.2.10
	>=media-libs/libemf-1.0
	sys-apps/supersed
	gnome? ( gnome-base/gnome )
	kde? ( kde-base/kde )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	local config_opts
	config_opts="--enable-emf"

	if [ "`use kde`" ]; then
		need-kde 2
		config_opts="${config_opts} --with-kdedir=${KDEDIR}" ;
	else
		config_opts="${config_opts} --without-kdedir"
	fi

	if [ "`use gnome`" ] ; then
		config_opts="${config_opts} --with-gnomedir=/usr" ;
	else
		config_opts="${config_opts} --without-gnomedir" ;
	fi

	if [ "`use nls`" ] ; then
		config_opts="${config_opts} --enable-locales \
			--with-localedir=/usr/share/locale"
	else
		config_opts="${config_opts} --disable-locales \
			--without-localedir"
	fi

	econf ${config_opts} \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	dodir ${KDEDIR}/share/applnk/Graphics
	dodir ${KDEDIR}/share/mimelnk/application
	dodir ${KDEDIR}/share/icons/hicolor/32x32/mimetypes
	dodir /usr/share/mime-types
   	dodir /usr/share/pixmaps/mc

	make DESTDIR="${D}" install || die "make install failed"

	if ! use kde; then
		rm -rf ${D}/${KDEDIR}
	fi

	if ! use gnome; then
		rm -rf ${D}/usr/share/pixmaps ${D}/usr/share/mime-types
	fi

	dodoc ChangeLog INSTALL README TODO
	insinto /usr/share/${PN}/examples
	doins ${S}/examples/*
}
