# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/chemtool/chemtool-1.5.ebuild,v 1.3 2003/02/13 09:21:18 vapier Exp $

IUSE="gnome kde nls"

DESCRIPTION="Chemtool is a program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
IUSE="gnome kde nls"
KEYWORDS="x86"

DEPEND=">=media-gfx/transfig-3.2.3d
		>=x11-libs/gtk+-1.2.10
		gnome? ( gnome-base/gnome )
		kde? ( kde-base/kde )
		nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}

	echo ">>> Patching configure.in..."
	patch ${S}/configure.in \
		${FILESDIR}/configure.in-${P}-gentoo.diff \
		&>/dev/null

	echo ">>> Patching config.h.in..."
	patch ${S}/config.h.in \
		${FILESDIR}/config.h.in-${P}-gentoo.diff \
		&>/dev/null

	echo ">>> Patching Makefile.in..."
	patch ${S}/Makefile.in \
		${FILESDIR}/Makefile.in-${P}-gentoo.diff \
		&>/dev/null

	echo ">>> Patching src-cht/Makefile.in..."
	patch ${S}/src-cht/Makefile.in \
		${FILESDIR}/src-cht-Makefile.in-${P}-gentoo.diff \
		&>/dev/null

	echo ">>> Running autoconf..."
	cd "${S}" && autoconf
}

src_compile() {
	local config_opts

	if [ "`use kde`" ]; then
		inherit kde-functions
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
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localedir=${D}/usr/share/locale \
		gnomedir=${D}/usr \
		kdedir=${D}/${KDEDIR} \
		install \
		|| die "make install failed"

	# Install documentation.
	dodoc ChangeLog INSTALL README TODO

	insinto /usr/share/${PN}/examples
	doins ${S}/examples/*
}
