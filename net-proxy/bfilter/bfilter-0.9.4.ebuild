# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/bfilter/bfilter-0.9.4.ebuild,v 1.1 2005/09/19 05:35:35 mrness Exp $

inherit eutils

DESCRIPTION="An ad-filtering web proxy featuring an effective heuristic ad-detection algorithm"
HOMEPAGE="http://bfilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bfilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X debug"

RDEPEND="sys-libs/zlib
	dev-libs/popt
	=dev-libs/libsigc++-1.2*
	X? ( =dev-cpp/gtkmm-2.2* )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	# Provide user, group and chroot privilege lowering
	epatch ${FILESDIR}/${P}-droppriv.patch
}

src_compile() {
	econf `use_enable debug` `use_with X gui` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# This is also created by openssh for privilege separation
	keepdir /var/empty

	doman ${FILESDIR}/bfilter.8

	dodoc AUTHORS ChangeLog
	dohtml doc/*.png doc/*.html

	newinitd ${FILESDIR}/bfilter.init bfilter
	newconfd ${FILESDIR}/bfilter.conf bfilter
}

pkg_preinst() {
	enewgroup bfilter
	enewuser bfilter -1 -1 -1 bfilter
}
