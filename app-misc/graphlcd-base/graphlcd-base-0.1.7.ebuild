# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="2"

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
}

src_install() {

	make DESTDIR="${D}"/usr LIBDIR="${D}"/usr/$(get_libdir) install || die "make install failed"

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
