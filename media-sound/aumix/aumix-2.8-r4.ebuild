# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8-r4.ebuild,v 1.9 2006/04/23 04:08:51 tcort Exp $

inherit eutils

DESCRIPTION="Aumix volume/mixer control program"
HOMEPAGE="http://jpj.net/~trevor/aumix.html"
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE="gpm gtk nls"

#alsa support is broken in 2.8	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.19.3 )
	gtk? ( >=x11-libs/gtk+-2.0.0 )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	sys-apps/findutils
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-nohome.patch
	epatch "${FILESDIR}"/${P}-close-dialogs.patch
	epatch "${FILESDIR}"/${P}-save_load.patch
	epatch "${FILESDIR}"/${P}-nls.patch
	epatch "${FILESDIR}/${P}-mute.patch"

	# Prevent auto* from rerunning... bug #70379
	touch aclocal.m4 configure
	find . -name Makefile.in -o -name stamp-h.in -print0 | xargs -0 touch;
	touch configure
}

src_compile() {
	local myconf="--without-gtk1"

	# use_with borks becasue of bad configure script.
	if ! use gtk; then
		myconf="${myconf} --without-gtk"
	fi

	if ! use gpm; then
		myconf="${myconf} --without-gpm"
	fi

	econf \
		`use_enable nls` \
		${myconf} || die
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	newinitd "${FILESDIR}"/aumix.rc6 aumix

	if use gtk; then
		doicon data/aumix.xpm
		make_desktop_entry aumix Aumix aumix.xpm
	fi
}
