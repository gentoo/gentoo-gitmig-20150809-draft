# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/readahead-list/readahead-list-0.20050320.2320.ebuild,v 1.1 2005/03/21 07:22:25 robbat2 Exp $

DESCRIPTION="Perform readahead(2) to pre-cache files."
HOMEPAGE="http://tirpitz.iat.sfu.ca/"
SRC_URI="${HOMEPAGE}/custom-software/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# I'm not entirely certain about this
# need to check if other libc variants provide readahead(2)
DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	into /
	dosbin readahead-list
	cd ${S}/init/gentoo/
	newinitd init.d-readahead-list readahead-list
	newconfd conf.d-readahead-list readahead-list
	insinto /etc/readahead-list
	# default config
	cd ${S}/scripts/
	newins readahead.runlevel-default.list runlevel-default
	newins readahead.runlevel-boot.list runlevel-boot
	newins readahead._sbin_rc.list exec_sbin_rc
	# docs
	cd ${S}
	dodoc README
	docinto scripts
	dodoc scripts/*
}
