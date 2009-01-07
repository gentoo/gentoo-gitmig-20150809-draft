# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpcpp/ncmpcpp-0.2.5.ebuild,v 1.3 2009/01/07 21:32:59 gentoofan23 Exp $

EAPI="2"
inherit eutils

DESCRIPTION="An ncurses mpd client, ncmpc clone with some new features, written in C++"
HOMEPAGE="http://unkart.ovh.org/ncmpcpp"
SRC_URI="http://unkart.ovh.org/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE="curl taglib unicode"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="sys-libs/ncurses[unicode?]
	curl? ( net-misc/curl )
	taglib? ( media-libs/taglib )"

src_configure() {
	econf $(use_enable unicode) $(use_with curl) $(use_with taglib)
}

src_install() {
	emake install DESTDIR="${D}" docdir="/usr/share/doc/${PF}" \
		|| die "install failed"
	prepalldocs
}

pkg_postinst() {
	echo
	elog "Example configuration files have been installed at"
	elog "${ROOT}usr/share/doc/${PF}"
	elog "${P} uses ~/.ncmpcpp/config and ~/.ncmpcpp/keys"
	elog "as user configuration files."
	echo
	elog "This version of ncmpcc uses features from mpd-0.14, so"
	elog "we recommend you use this with >=mpd-0.14_alpha1."
	echo
}
