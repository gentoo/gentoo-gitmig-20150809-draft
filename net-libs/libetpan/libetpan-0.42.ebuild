# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libetpan/libetpan-0.42.ebuild,v 1.7 2006/04/08 13:19:52 blubb Exp $

DESCRIPTION="A portable, efficient middleware for different kinds of mail access."
HOMEPAGE="http://libetpan.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="berkdb debug gnutls sasl ssl"

DEPEND="virtual/libc
	berkdb? ( sys-libs/db )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )
	sasl? ( dev-libs/cyrus-sasl )"

src_compile() {
	local myconf

	econf \
		`use_enable debug` \
		`use_enable berkdb db` \
		`use_with gnutls` \
		`use_with ssl openssl` \
		`use_with sasl` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc NEWS TODO ChangeLog
}

pkg_postinst() {
	ewarn "The soname for libetpan has cahnged in this release."
	ewarn "It is recommended that you run revdep-rebuild to fix any linking errors caused by this."
}
