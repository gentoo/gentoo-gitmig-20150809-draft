# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrpath/chrpath-0.13-r2.ebuild,v 1.2 2011/10/10 22:28:37 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="chrpath can modify the rpath and runpath of ELF executables"
HOMEPAGE="http://directory.fsf.org/project/chrpath/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-multilib.patch \
		"${FILESDIR}"/${PN}-keepgoing.patch \
		"${FILESDIR}"/${P}-testsuite-1.patch

	eautoreconf
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		install

	rm -f \
		"${ED}"usr/lib*/lib*.{a,la} \
		"${ED}"usr/share/doc/${PF}/{COPYING,INSTALL}
}
