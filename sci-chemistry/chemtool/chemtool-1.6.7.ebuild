# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/chemtool/chemtool-1.6.7.ebuild,v 1.1 2005/08/08 10:25:01 phosphan Exp $

inherit eutils kde-functions

DESCRIPTION="program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="gtk2 gnome kde nls"

DEPEND=">=media-gfx/transfig-3.2.3d
	    || 	(
			gtk2? ( =x11-libs/gtk+-2* )
			=x11-libs/gtk+-1*
			)
		x86? ( >=media-libs/libemf-1.0 )"

src_compile() {
	local config_opts
	local mycppflags
	local mykdedir
	if [ -z "${KDEDIR}" ]; then
		mykdedir="bogus_kde"
	else
		mykdedir="${KDEDIR}"
	fi
	if [ ${ARCH} = "x86"  ]; then
		config_opts="--enable-emf"
		mycppflags="${mycppflags} -I /usr/include/libEMF"
	fi

	if ! use gtk2; then
		config_opts="${config_opts} --enable-gtk1"
	fi

	sed -e "s:\(^CPPFLAGS.*\):\1 ${mycppflags}:" -i Makefile.in || \
		die "could not append cppflags"

	if use kde; then
		config_opts="${config_opts} --with-kdedir=${mykdedir}" ;
	fi

	if use gnome ; then
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
