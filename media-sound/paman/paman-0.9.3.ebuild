# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/paman/paman-0.9.3.ebuild,v 1.1 2006/08/31 09:33:20 flameeyes Exp $

DESCRIPTION="Pulseaudio Manager, a simple GTK frontend for Pulseaudio"
HOMEPAGE="http://0pointer.de/lennart/projects/paman/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"

IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/libglademm-2.4
	>=media-sound/pulseaudio-0.9.2"

src_compile() {
	# Lynx is used during make dist basically
	econf \
		--disable-lynx || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dohtml -r doc
	dodoc README doc/todo
}
