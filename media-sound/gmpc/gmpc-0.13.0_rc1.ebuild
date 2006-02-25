# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.13.0_rc1.ebuild,v 1.1 2006/02/25 10:36:44 ticho Exp $

IUSE="gnome"

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://etomite.qballcow.nl/qgmpc-0.12.html"
SRC_URI="http://download.qballcow.nl/programs/${PN}-0.13/${P/_/-}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	dev-perl/XML-Parser
	>=media-libs/libmpd-0.12.0_rc1"

S="${WORKDIR}/${P%_*}"

src_compile() {
	einfo "S='${S}'"
	econf $(use_enable gnome gnome-vfs) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

DOCS="AUTHORS ChangeLog NEWS README"

