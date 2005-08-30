# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/zapping/zapping-0.9.6.ebuild,v 1.1 2005/08/30 01:07:17 vanquirius Exp $

inherit gnome2

DESCRIPTION="TV- and VBI- viewer for the Gnome environment"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="nls pam X"

DEPEND=">=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gconf-2.4
	>=x11-libs/gtk+-2.0.0
	dev-libs/libxml2
	>=sys-devel/gettext-0.10.36
	>=media-libs/zvbi-0.2
	>=media-libs/rte-0.5.2
	>=media-sound/esound-0.2.34
	app-text/scrollkeeper
	>=sys-apps/sed-4
	>=media-libs/zvbi-0.2.9"

src_unpack() {
	unpack ${A}; cd ${S}
	# fix scrollkeeper violations, bug 98968
	gnome2_omf_fix {.,*,*/*}/Makefile.in
}

src_compile() {
	econf `use_enable nls` \
		`use_enable pam` \
		`use_with X x` || die "econf failed"

	emake || die "emake failed"
}

pkg_preinst() {
	rm ${D}/usr/bin/zapzilla
	dosym /usr/bin/zapping /usr/bin/zapzilla
	# thx to Andreas Kotowicz <koto@mynetix.de> for mailing me this fix:
	rm ${D}/usr/bin/zapping_setup_fb
	dobin zapping_setup_fb/zapping_setup_fb
	dodoc AUTHORS BUGS ChangeLog NEWS README README.plugins THANKS TODO
}
