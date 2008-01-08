# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rmake/rmake-1.0.13.ebuild,v 1.1 2008/01/08 01:15:33 rbu Exp $

inherit eutils multilib

DESCRIPTION="repository-based build system"
HOMEPAGE="http://wiki.rpath.com/wiki/Conary:About_rMake"
SRC_URI="ftp://download.rpath.com/${PN}/${P}.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/python-2.4*
		sys-libs/libcap
		app-admin/conary"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	fperms 04755 /usr/libexec/rmake/chroothelper
	for x in /var/{rmake,{log,lib,run}/rmake} /{etc,srv}/rmake; do
		keepdir "$x"
		fowners rmake:rmake "$x"
	done
	fperms 700 /var/rmake

	newinitd extra/rmake.gentoo.init rmake
	dodoc NEWS
}

pkg_setup() {
	enewgroup rmake
	enewgroup rmake-chroot
	enewuser rmake -1 -1 /srv/rmake "rmake"
	enewuser rmake-chroot -1 -1 / "rmake-chroot"
}
