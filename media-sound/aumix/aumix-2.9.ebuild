# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.9.ebuild,v 1.1 2010/04/14 11:50:35 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Aumix volume/mixer control program"
HOMEPAGE="http://jpj.net/~trevor/aumix.html"
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="gpm gtk nls"

RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.19.3 )
	gtk? ( x11-libs/gtk+:2 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-apps/findutils
	nls? ( sys-devel/gettext )"

src_prepare() {
	# 2.9 was released, none of this was applied. why?
	epatch "${FILESDIR}"/${PN}-2.8-nohome.patch \
		"${FILESDIR}"/${PN}-2.8-save_load.patch \
		"${FILESDIR}"/${PN}-2.8-nls.patch \
		"${FILESDIR}"/${PN}-2.8-mute.patch \
		"${FILESDIR}"/${PN}-2.8-noninter_strncpy.patch

	# Prevent autotools from rerunning, bug #70379.
	find . -print0 |xargs -0 touch
}

src_configure() {
	local myconf

	use gtk || myconf="${myconf} --without-gtk"
	use gpm || myconf="${myconf} --without-gpm"

	econf \
		$(use_enable nls) \
		--without-gtk1 \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	newinitd "${FILESDIR}"/aumix.rc6 aumix

	if use gtk; then
		doicon data/aumix.xpm
		make_desktop_entry aumix Aumix aumix
	fi
}
