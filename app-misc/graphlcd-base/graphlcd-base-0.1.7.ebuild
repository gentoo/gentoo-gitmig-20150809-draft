# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/graphlcd-base/graphlcd-base-0.1.7.ebuild,v 1.2 2011/01/25 19:02:16 hd_brummy Exp $

EAPI="3"

inherit eutils flag-o-matic multilib

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/graphlcd"
SRC_URI="http://projects.vdr-developer.org/attachments/download/414/${P}.tgz"

KEYWORDS="~amd64 ~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="g15"

DEPEND=""

RDEPEND="g15? ( app-misc/g15daemon )"

src_prepare() {

	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
	epatch "${FILESDIR}/${PN}-0.1.5-nostrip.patch"

	sed -i glcdskin/Makefile -e "s:-shared:\$(LDFLAGS) -shared:"
}

src_install() {

	make DESTDIR="${D}"/usr LIBDIR="${D}"/usr/$(get_libdir) install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
