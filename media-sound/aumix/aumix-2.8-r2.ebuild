# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8-r2.ebuild,v 1.14 2004/11/11 19:53:44 kloeri Exp $

inherit eutils

DESCRIPTION="Aumix volume/mixer control program"
HOMEPAGE="http://jpj.net/~trevor/aumix/"
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="gtk gtk2 gpm nls"

#alsa support is broken in 2.8	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
RDEPEND=">=sys-libs/ncurses-5.2
	gpm? ( >=sys-libs/gpm-1.19.3 )
	gtk? ( !gtk2? ( =x11-libs/gtk+-1.2* )
	       gtk2? ( >=x11-libs/gtk+-2.0.0 ) )"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	sys-apps/findutils
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-nohome.patch
	epatch ${FILESDIR}/${P}-close-dialogs.patch
	epatch ${FILESDIR}/${P}-save_load.patch
	epatch ${FILESDIR}/${P}-nls.patch

	# Prevent auto* from rerunning... bug #70379
	touch aclocal.m4
	find . -name Makefile.in -exec touch {} \;
	find . -name stamp-h.in -exec touch {} \;
	touch configure
}

src_compile() {
#	`use_with alsa`

	# use_with borks becasue of bad configure script.
	if use gtk; then
		if use gtk2; then
			myconf="${myconf} --without-gtk1";
		else
			myconf="${myconf} --without-gtk";
		fi
	else
		myconf="${myconf} --without-gtk --without-gtk1";
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
	einstall

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	insinto /usr/share/applications
	doins ${FILESDIR}/aumix.desktop

	dodir /usr/share/pixmaps
	ln -s ../aumix/aumix.xpm ${D}/usr/share/pixmaps

	newinitd ${FILESDIR}/aumix.rc6 aumix
}
