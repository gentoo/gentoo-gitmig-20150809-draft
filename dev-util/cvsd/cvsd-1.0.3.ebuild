# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsd/cvsd-1.0.3.ebuild,v 1.1 2004/11/14 15:33:27 max Exp $

inherit eutils

DESCRIPTION="CVS pserver daemon."
HOMEPAGE="http://tiefighter.et.tudelft.nl/~arthur/cvsd/"
SRC_URI="http://tiefighter.et.tudelft.nl/~arthur/cvsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="tcpd"

DEPEND="virtual/libc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
RDEPEND="${DEPEND}
	>=dev-lang/perl-5.8.0
	>=dev-util/cvs-1.11.6"

src_compile() {
	local myconf
	myconf="${myconf} `use_with tcpd libwrap`"

	econf ${myconf} || die "econf failed"
	emake || die "compile problem"
}

src_install() {
	enewgroup cvsd
	enewuser cvsd -1 /bin/false /var/lib/cvsd cvsd

	make DESTDIR="${D}" install || die "make install failed"
	dosed 's:^Repos:# Repos:g' /etc/cvsd/cvsd.conf
	keepdir /var/lib/cvsd

	dodoc AUTHORS COPYING FAQ INSTALL NEWS README TODO ChangeLog

	exeinto /etc/init.d
	newexe "${FILESDIR}/cvsd.rc6" cvsd
}

pkg_postinst() {
	einfo "To configure cvsd please read /usr/share/doc/${PF}/README.gz"
}
