# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-2.2.0.ebuild,v 1.7 2005/03/27 03:37:35 weeve Exp $

inherit eutils

DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz
	prelude? ( http://www.exaprobe.com/labs/downloads/Nessus_Patch/old/patch_0.nessus-core.2.0.7 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64 ~ppc64"
IUSE="X tcpd gtk2 debug prelude"

DEPEND="=net-analyzer/nessus-libraries-${PV}
	=net-analyzer/libnasl-${PV}
	tcpd? ( sys-apps/tcp-wrappers )
	X? ( virtual/x11
		!gtk2? ( =x11-libs/gtk+-1.2* )
		gtk2? ( =x11-libs/gtk+-2* )
	)
	prelude? ( dev-libs/libprelude )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	if use prelude; then
		epatch ${DISTDIR}/patch_0.nessus-core.2.0.7
		epatch ${FILESDIR}/patch_1.nessus-core.2.0.7
	fi
}

src_compile() {
	local myconf
	# no use_enable because of bug 31670
	if use tcpd; then
		myconf="${myconf} --enable-tcpwrappers"
	fi
	if use debug; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi
	if use prelude; then
		export LIBPRELUDE_CONFIG=/usr/bin/libprelude-config
	fi
	use X || myconf="${myconf} --disable-gtk"
	econf ${myconf} || die "configure failed"
	emake -j1 || die "emake failed"

}

src_install() {
	make \
		DESTDIR=${D} \
		install || die "Install failed nessus-core"
	cd ${S}
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/nessusd-r6 nessusd
	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users
}
