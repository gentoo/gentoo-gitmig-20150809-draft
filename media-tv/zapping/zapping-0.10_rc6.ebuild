# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/zapping/zapping-0.10_rc6.ebuild,v 1.2 2007/11/27 11:06:58 zzam Exp $

inherit gnome2

MY_P=${P/_rc/cvs}
DESCRIPTION="TV- and VBI- viewer for the Gnome environment"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="arts esd lirc nls pam vdr zvbi X"

DEPEND=">=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gconf-2.0
	>=x11-libs/gtk+-2.4.0
	dev-libs/libxml2
	>=sys-devel/gettext-0.10.36
	zvbi? ( >=media-libs/zvbi-0.2.11 )
	vdr? ( >=media-libs/rte-0.5.2 )
	lirc? ( app-misc/lirc )
	esd? ( >=media-sound/esound-0.2.34 )
	arts? ( kde-base/arts )
	>=app-text/scrollkeeper-0.3.5
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf `use_enable nls` \
		`use_enable pam` \
		`use_with zvbi` \
		`use_with X x` || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	gnome2_src_install

	# thx to Andreas Kotowicz <koto@mynetix.de> for mailing me this fix:
	rm "${D}"/usr/bin/zapping_setup_fb
	dobin zapping_setup_fb/zapping_setup_fb
	dodoc AUTHORS BUGS ChangeLog NEWS README README.plugins THANKS TODO
}
