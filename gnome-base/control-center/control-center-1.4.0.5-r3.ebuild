# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.5-r3.ebuild,v 1.2 2006/09/05 01:38:38 kumba Exp $

inherit gnome.org eutils multilib gnome2

DESCRIPTION="The GNOME control-center"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND="<gnome-base/gnome-vfs-1.9.0
	>=media-libs/gdk-pixbuf-0.11.0-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-cflags.patch

	# Patch for partial linguas (Bug #114809)
	epatch ${FILESDIR}/${P}-linguas.patch

	gnome2_omf_fix
}

src_compile() {
	econf $(use_enable nls) || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall || die "failed to install"
	dodoc AUTHORS ChangeLog README NEWS
}
