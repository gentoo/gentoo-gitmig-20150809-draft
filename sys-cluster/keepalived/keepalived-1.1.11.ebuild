# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.1.11.ebuild,v 1.13 2007/06/26 02:50:56 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="add a strong & robust keepalive facility to the Linux Virtual Server project"
HOMEPAGE="http://www.keepalived.org/"
SRC_URI="http://www.keepalived.org/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ppc ~ppc64 s390 sparc x86"
IUSE="debug profile"

DEPEND="dev-libs/popt
	sys-apps/iproute2"

src_compile() {
	local myconf

	myconf="--prefix=/"

	use debug && myconf="${myconf} --enable-debug"

	# disable -fomit-frame-pointer for profiling
	if use profile; then
		filter-flags -fomit-frame-pointer
		myconf="${myconf} --enable-profile"
	fi

	./configure ${myconf} || die "configure failed"
	emake || die "make failed (myconf=${myconf})"
}

src_install() {
	einstall || die

	newinitd ${FILESDIR}/init-keepalived keepalived

	dodoc doc/keepalived.conf.SYNOPSIS
	doman doc/man/man*/*
}

pkg_postinst() {
	einfo ""
	einfo "If you want Linux Virtual Server support in keepalived then you must emerge an"
	einfo "LVS patched kernel, compile with ipvs support either as a module or built into"
	einfo "the kernel, emerge the ipvsadm userland tools, and reemerge keepalived."
	einfo ""
	einfo "For debug support add USE=\"debug\" to your /etc/make.conf"
	einfo ""
}
