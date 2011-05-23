# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/chemtool/chemtool-1.6.12-r1.ebuild,v 1.1 2011/05/23 15:18:31 jlec Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="A GTK program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emf gnome nls"

RDEPEND="
	media-gfx/transfig
	x11-libs/gtk+:2
	emf? ( media-libs/libemf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-no-underlinking.patch
	eautoreconf
}

src_configure() {
	local mycppflags

	if use emf; then
		mycppflags="${mycppflags} -I /usr/include/libEMF"
	fi

	sed -e "s:\(^CPPFLAGS.*\):\1 ${mycppflags}:" -i Makefile.in || \
		die "could not append cppflags"

	econf \
		--without-kdedir \
		$(use_with gnome gnomedir /usr) \
		$(use_enable emf) \
		--enable-menu
}

src_install() {
	default
	insinto /usr/share/${PN}/examples
	doins "${S}"/examples/*
	if ! use nls; then rm -rf "${ED}"/usr/share/locale; fi

	insinto /usr/share/pixmaps
	doins chemtool.xpm
	make_desktop_entry ${PN} Chemtool ${PN} "Education;Science;Chemistry"
}
