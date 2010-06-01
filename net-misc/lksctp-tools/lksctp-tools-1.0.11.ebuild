# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lksctp-tools/lksctp-tools-1.0.11.ebuild,v 1.1 2010/06/01 00:10:30 flameeyes Exp $

inherit eutils multilib

DESCRIPTION="Tools for Linux Kernel Stream Control Transmission Protocol implementation"
HOMEPAGE="http://lksctp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lksctp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# This is only supposed to work with Linux to begin with.
DEPEND=">=sys-kernel/linux-headers-2.6"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.0.8-prefix.patch #181602
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README ROADMAP doc/*txt || die

	newdoc src/withsctp/README README.withsctp || die

	# Don't install static library or libtool file, since this is used
	# only as preloadable library.
	rm "${D}"/usr/$(get_libdir)/${PN}/*.a || die

	find "${D}" -name '*.la' -delete || die
}
