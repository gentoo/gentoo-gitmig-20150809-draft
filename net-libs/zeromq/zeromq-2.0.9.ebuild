# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zeromq/zeromq-2.0.9.ebuild,v 1.2 2011/03/04 17:26:53 djc Exp $

# NOTES:
# 1- use flag 'pgm' (OpenPGM support) must be masked by profiles for ARM archs;
# 2- $(use_with pgm) doesn't work due to a broken configure.in (I'm fixing it
#    with upstream);
# 3- libpgm is bundled inside 0MQ's source because the library isn't complete
#    and fully installable alone, so for now upstream has decided to bundle
#    it until libpgm can be packaged as a separate component;

EAPI=3

DESCRIPTION="ZeroMQ is a brokerless messaging kernel with extremely high performance."
HOMEPAGE="http://www.zeromq.org/"
SRC_URI="http://www.zeromq.org/local--files/area:download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pgm static-libs"

RDEPEND="sys-apps/util-linux"
DEPEND="${RDEPEND}
	pgm? (
		app-arch/gzip
		dev-util/pkgconfig
	)"

src_configure() {
	local myconf
	use pgm && myconf="--with-pgm"
	econf \
		$(use_enable static-libs static) \
		${myconf} \
		--disable-dependency-tracking \
		--enable-fast-install
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS README AUTHORS ChangeLog || die "dodoc failed."

	# remove useless .a and .la files (only for non static compilation)
	find "${D}" -name '*.la' -delete
}
