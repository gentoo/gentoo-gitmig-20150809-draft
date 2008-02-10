# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.9.0.ebuild,v 1.6 2008/02/10 16:25:42 philantrop Exp $

inherit autotools eutils

DESCRIPTION="Synchronize Windows CE devices with Linux. GNOME Plugin for CE devices."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-pda/synce-libsynce-0.9.0
	>=app-pda/synce-librapi2-0.9.0
	>=gnome-base/gnome-vfs-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gcc4.patch"

	# Get rid of -Werror and respect the user's CFLAGS. cf. bug 206014.
	sed -i -e "/AM_CFLAGS/s:-g.*$:${CFLAGS}:" "${S}"/src/Makefile.am \
		|| die "sed to fix AM_CFLAGS failed"

	eautoreconf
	econf || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
