# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linphone/linphone-0.12.1.ebuild,v 1.1 2004/01/03 02:10:56 stkn Exp $

IUSE="doc gnome nls xv alsa ipv6"

DESCRIPTION="Linphone is a Web phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${PV}/source/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="dev-libs/glib
	>=net-libs/libosip-0.9.6
	dev-util/pkgconfig
	x86? (
		xv? ( dev-lang/nasm )
	     )
	gnome? (
		 >=gnome-base/gnome-panel-2
		 >=gnome-base/libgnome-2
		 >=gnome-base/libgnomeui-2
		 >=x11-libs/gtk+-2
		)
	alsa? ( >media-libs/alsa-lib-0.5 )
	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-include-fix.diff
}

src_compile() {

	local myconf

	if [ `use gnome` ]
	then
		einfo "Building with Gnome gui"
		myconf="${myconf} --enable-gnome_ui=yes"
		myconf="${myconf} --enable-platform-gnome-2"
	else
		einfo "Building without Gnome gui"
		myconf="${myconf} --enable-gnome_ui=no"
	fi

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"

	econf \
		`use_enable alsa` \
		`use_enable nls` \
		`use_enable ipv6` \
		${myconf} || die
	emake || die
}

src_install () {
	dodoc ABOUT-NLS COPYING README AUTHORS BUGS INSTALL NEWS ChangeLog TODO
	einstall PIXDESTDIR=${D} || die
}
