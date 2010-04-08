# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.6.2.ebuild,v 1.1 2010/04/08 16:05:26 ssuominen Exp $

EAPI=2

DESCRIPTION="MemProf - Profiling and leak detection"
HOMEPAGE="http://www.secretlabs.de/projects/memprof/"
SRC_URI="http://www.secretlabs.de/projects/memprof/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_configure() {
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README NEWS

	find "${D}" -name '*.la' -delete
}
