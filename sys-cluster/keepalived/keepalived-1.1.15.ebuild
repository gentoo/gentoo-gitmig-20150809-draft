# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.1.15.ebuild,v 1.7 2008/05/07 18:52:53 corsair Exp $

inherit flag-o-matic autotools

DESCRIPTION="add a strong & robust keepalive facility to the Linux Virtual Server project"
HOMEPAGE="http://www.keepalived.org/"
SRC_URI="http://www.keepalived.org/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~s390 ~sparc x86"
IUSE="debug profile"

RDEPEND="dev-libs/popt
	sys-apps/iproute2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	=sys-kernel/linux-headers-2.6*"

src_unpack() {
	unpack ${A}

	# This patch allows us to avoid needing kernel sources for the configure phase
	EPATCH_OPTS="-p1 -d${S}" epatch \
		"${FILESDIR}"/${PN}-1.1.13-do-not-need-kernel-sources.patch
	cd "${S}"
	eautoreconf

	# Prepare a suitable copy of the IPVS headers
	# So that we don't need kernel sources at all!
	mkdir -p "${S}"/include/net || die "Failed to prepare ipvs header directory"
	cp -f "${FILESDIR}"/${PN}-1.1.13-linux-2.6.21-ip_vs.h \
		"${S}"/include/net/ip_vs.h || die "Failed to add ipvs header"

	# Ensure that keepalived can find the header that we are injecting
	append-flags -I"${S}"/include
}

src_compile() {
	local myconf

	myconf="--enable-vrrp"

	# This is not an error
	# The upstream makefile used to add man/, but doesn't anymore
	myconf="${myconf} --mandir=/usr/share/man"

	use debug && myconf="${myconf} --enable-debug"

	# disable -fomit-frame-pointer for profiling
	if use profile; then
		filter-flags -fomit-frame-pointer
		myconf="${myconf} --enable-profile"
	fi

	econf ${myconf} STRIP=/bin/true || die "configure failed"
	emake || die "emake failed (myconf=${myconf})"
}

src_install() {
	# Not parallel safe
	emake -j1 install DESTDIR="${D}" || die "emake install failed"

	newinitd "${FILESDIR}"/init-keepalived keepalived

	dodoc doc/keepalived.conf.SYNOPSIS
	dodoc README CONTRIBUTORS INSTALL VERSION ChangeLog AUTHOR TODO

	docinto genhash
	dodoc genhash/README genhash/AUTHOR genhash/ChangeLog genhash/VERSION
	# This was badly named by upstream, it's more HOWTO than anything else.
	newdoc INSTALL INSTALL+HOWTO

	# Security risk to bundle SSL certs
	rm -f "${D}"/etc/keepalived/samples/*.pem
	# Clean up sysvinit files
	rm -rf "${D}"/etc/sysconfig "${D}"/etc/rc.d/
}

pkg_postinst() {
	elog "For internal debug support, compile with USE=debug via package.use"
}
