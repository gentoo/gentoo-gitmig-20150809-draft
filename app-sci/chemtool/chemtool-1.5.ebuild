# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/chemtool/chemtool-1.5.ebuild,v 1.5 2003/04/18 17:12:23 seemant Exp $

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
	>=x11-libs/gtk+-1.2.10
	gnome? ( gnome-base/gnome )
	kde? ( kde-base/kde )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/configure.in-${P}-gentoo.diff
	epatch ${FILESDIR}/config.h.in-${P}-gentoo.diff
	epatch ${FILESDIR}/Makefile.in-${P}-gentoo.diff
	epatch ${FILESDIR}/src-cht-Makefile.in-${P}-gentoo.diff
	autoconf || die
}

src_compile() {
	local config_opts

	if [ "`use kde`" ]; then
		need-kde 2
		config_opts="--with-kdedir=${KDEDIR}" ;
	else
		config_opts="--without-kdedir"
	fi

	if [ "`use gnome`" ] ; then
		config_opts="${config_opts} --with-gnomedir=/usr" ;
	else
		config_opts="${config_opts} --without-gnomedir" ;
	fi

	if [ "`use nls`" ] ; then
		config_opts="${config_opts} --enable-locales \
			--with-localdir=/usr/share/locale"
	else
		config_opts="${config_opts} --disable-locales" ;
	fi

	econf ${config_opts} \
		|| die "./configure failed"

	emake || die "make failed"
}

src_install () {
	einstall \
		gnomedir=${D}/usr \
		kdedir=${D}/${KDEDIR} \
		localedir=${D}/usr/share/locale \
		|| die "make install failed"

	dodoc ChangeLog INSTALL README TODO
	insinto /usr/share/${PN}/examples
	doins ${S}/examples/*
}
