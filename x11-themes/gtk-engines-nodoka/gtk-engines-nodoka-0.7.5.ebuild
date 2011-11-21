# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-nodoka/gtk-engines-nodoka-0.7.5.ebuild,v 1.2 2011/11/21 22:35:46 flameeyes Exp $

EAPI=1
MY_P="gtk-nodoka-engine-${PV}"

DESCRIPTION="GTK+ engine and themes developed by the Fedora Project"
HOMEPAGE="https://fedorahosted.org/nodoka/"
SRC_URI="https://fedorahosted.org/releases/n/o/nodoka/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="animation-rtl"

RDEPEND=">=x11-libs/gtk+-2.18.0:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--enable-animation \
		$(use_enable animation-rtl animationtoleft)

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO || die "dodoc failed"
	find "${D}" -name "*.la" -delete || die
}
