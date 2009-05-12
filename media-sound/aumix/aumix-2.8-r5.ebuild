# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8-r5.ebuild,v 1.1 2009/05/12 11:43:57 ssuominen Exp $

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
	gtk? ( >=x11-libs/gtk+-2:2 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-apps/findutils
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nohome.patch \
		"${FILESDIR}"/${P}-close-dialogs.patch \
		"${FILESDIR}"/${P}-save_load.patch \
		"${FILESDIR}"/${P}-nls.patch \
		"${FILESDIR}"/${P}-mute.patch \
		"${FILESDIR}"/${P}-noninter_strncpy.patch

	# Prevent autotools from rerunning, bug #70379.
	touch aclocal.m4 configure
	find . -name Makefile.in -o -name stamp-h.in -print0 | xargs -0 touch;
	touch configure
}

src_configure() {
	local myconf="--without-gtk1"

	use gtk || myconf="${myconf} --without-gtk"
	use gpm || myconf="${myconf} --without-gpm"

	econf \
		$(use_enable nls) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	newinitd "${FILESDIR}"/aumix.rc6 aumix

	if use gtk; then
		doicon data/aumix.xpm
		make_desktop_entry aumix Aumix aumix
	fi
}
