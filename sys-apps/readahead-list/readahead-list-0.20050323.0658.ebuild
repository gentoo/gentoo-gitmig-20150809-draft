# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/readahead-list/readahead-list-0.20050323.0658.ebuild,v 1.2 2005/03/23 08:33:36 robbat2 Exp $

DESCRIPTION="Perform readahead(2) to pre-cache files."
HOMEPAGE="http://tirpitz.iat.sfu.ca/"
SRC_URI="${HOMEPAGE}/custom-software/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

# I'm not entirely certain about this
# need to check if other libc variants provide readahead(2)
DEPEND="virtual/libc"

src_compile() {
	econf --sbindir=/sbin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# init scripts
	cd ${S}/contrib/init/gentoo/
	newinitd init.d-readahead-list readahead-list
	newconfd conf.d-readahead-list readahead-list

	# default config
	insinto /etc/readahead-list
	cd ${S}/contrib/data
	newins readahead.runlevel-default.list runlevel-default
	newins readahead.runlevel-boot.list runlevel-boot
	newins readahead._sbin_rc.list exec_sbin_rc

	# docs
	cd ${S}
	dodoc README
	if use doc; then
		docinto scripts
		dodoc contrib/scripts/*
		rm ${D}/usr/contrib/scripts/Makefile*
	fi
}
