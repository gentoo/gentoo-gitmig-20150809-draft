# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpcpp/ncmpcpp-0.2.4.ebuild,v 1.2 2008/12/06 00:00:14 gentoofan23 Exp $

inherit eutils

DESCRIPTION="An ncurses mpd client, ncmpc clone with some new features, written in C++"
HOMEPAGE="http://unkart.ovh.org/ncmpcpp"
SRC_URI="http://unkart.ovh.org/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE="curl taglib unicode"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="sys-libs/ncurses
	curl? ( net-misc/curl )
	taglib? ( media-libs/taglib )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use sys-libs/ncurses unicode && use unicode ; then
		eerror "Please recompile sys-libs/ncurses with the unicode useflag"
		die
	fi
}

src_compile() {
	econf $(use_enable unicode) $(use_with curl) $(use_with taglib) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" docdir="${ROOT}/usr/share/doc/${PF}" \
		|| die "install failed"
	prepalldocs
}

pkg_postinst() {
	echo
	elog "Example configuration files have been installed at"
	elog "${ROOT}usr/share/doc/${PF}"
	elog "${P} now uses ~/.ncmpcpp/config and ~/.ncmpcpp/keys"
	elog "as configuration files. If you have used a previous version,"
	elog "please move your configuration files to the new location."
	echo
}
