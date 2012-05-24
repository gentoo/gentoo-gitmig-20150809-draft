# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/tcb/tcb-1.0.6.ebuild,v 1.2 2012/05/24 05:09:54 vapier Exp $

EAPI="2"

inherit eutils multilib user

DESCRIPTION="Libraries and tools implementing the tcb password shadowing scheme"
HOMEPAGE="http://www.openwall.com/tcb/"
SRC_URI="ftp://ftp.openwall.com/pub/projects/tcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.75"
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

src_prepare() {
	# We don't have Openwall glibc extensions. The patch makes it possible
	# to run tcb with normal glibc. It has been reviewed by upstream, but
	# is not going to be accepted. The plan is to add support for sha hashes
	# to Openwall's crypto routines and use them when that's available.
	epatch "${FILESDIR}"/${PN}-gentoo.patch
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
