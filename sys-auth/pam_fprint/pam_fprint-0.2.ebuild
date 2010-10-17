# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_fprint/pam_fprint-0.2.ebuild,v 1.1 2010/10/17 22:54:30 xmw Exp $

EAPI=3

inherit autotools eutils multilib

DESCRIPTION="a simple PAM module which uses libfprint's functionality for authentication"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI="mirror://sourceforge/fprint/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-auth/libfprint
	sys-libs/pam"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-headers.patch

	# adjust /lib/security to architecture
	sed -i -e "/^pammoddir=/s:=.*:=\"${EPREFIX}\"/$(get_libdir)/security:" \
		src/Makefile.am || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	newbin src/pamtest pamtest.fprint || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
