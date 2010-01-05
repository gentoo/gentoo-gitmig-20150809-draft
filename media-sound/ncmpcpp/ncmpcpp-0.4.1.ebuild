# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpcpp/ncmpcpp-0.4.1.ebuild,v 1.3 2010/01/05 20:00:07 fauli Exp $

EAPI="2"
inherit eutils

DESCRIPTION="An ncurses mpd client, ncmpc clone with some new features, written in C++"
HOMEPAGE="http://unkart.ovh.org/ncmpcpp"
SRC_URI="http://unkart.ovh.org/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE="clock curl fftw iconv outputs taglib +threads unicode visualizer"
SLOT="0"
KEYWORDS="~amd64 hppa x86"

DEPEND="sys-libs/ncurses[unicode?]
	curl? ( net-misc/curl )
	fftw? ( sci-libs/fftw )
	iconv? ( virtual/libiconv )
	taglib? ( media-libs/taglib )"
RDEPEND="$DEPEND"

src_configure() {
	econf $(use_enable clock) \
		$(use_enable outputs) \
		$(use_enable unicode) \
		$(use_enable visualizer) \
		$(use_with curl) \
		$(use_with fftw) \
		$(use_with iconv) \
		$(use_with threads) \
		$(use_with taglib)
}

src_install() {
	emake install DESTDIR="${D}" docdir="/usr/share/doc/${PF}" \
		|| die "install failed"
}

pkg_postinst() {
	echo
	elog "Example configuration files have been installed at"
	elog "${ROOT}usr/share/doc/${PF}"
	elog "${P} uses ~/.ncmpcpp/config and ~/.ncmpcpp/keys"
	elog "as user configuration files."
	echo
	if use visualizer; then
	elog "If you want to use the visualizer, you need mpd with fifo enabled."
	echo
	fi
}
