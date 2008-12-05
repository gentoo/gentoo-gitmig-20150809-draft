# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpcpp/ncmpcpp-0.2.5.ebuild,v 1.1 2008/12/05 22:24:31 yngwin Exp $

EAPI="2"
inherit eutils

DESCRIPTION="An ncurses mpd client, ncmpc clone with some new features, written in C++"
HOMEPAGE="http://unkart.ovh.org/ncmpcpp"
SRC_URI="http://unkart.ovh.org/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE="curl taglib unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/ncurses[unicode]
	curl? ( net-misc/curl )
	taglib? ( media-libs/taglib )"
RDEPEND="${DEPEND}
	>=media-sound/mpd-0.14_alpha1"

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
	elog "${P} uses ~/.ncmpcpp/config and ~/.ncmpcpp/keys"
	elog "as user configuration files."
	echo
}
