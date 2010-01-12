# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/tcb/tcb-1.0.3-r1.ebuild,v 1.1 2010/01/12 17:59:48 phajdan.jr Exp $

inherit eutils multilib

DESCRIPTION="Libraries and tools implementing the tcb password shadowing scheme"
HOMEPAGE="http://www.openwall.com/tcb/"
SRC_URI="ftp://ftp.openwall.com/pub/projects/tcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pam"

DEPEND=">=sys-libs/libxcrypt-2.4
	pam? ( >=sys-libs/pam-0.75 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	for group in auth chkpwd shadow ; do
		enewgroup ${group}
	done

	mymakeopts="
		SLIBDIR=/$(get_libdir)
		LIBDIR=/usr/$(get_libdir)
		MANDIR=/usr/share/man
		DESTDIR='${D}'"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.0.2-build.patch
	epatch "${FILESDIR}"/${PN}-xcrypt.patch
	use pam || sed -i '/pam/d' Makefile
}

src_compile() {
	emake $mymakeopts || die "emake failed"
}

src_install() {
	emake $mymakeopts install || die "emake install failed"
	dodoc ChangeLog
}

pkg_postinst() {
	einfo "You must now run /sbin/tcb_convert to convert your shadow to tcb"
	einfo "To remove this you must first run /sbin/tcp_unconvert and then unmerge"
}
