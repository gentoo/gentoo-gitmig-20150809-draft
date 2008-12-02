# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rmake/rmake-1.0.8.ebuild,v 1.2 2008/12/02 17:14:46 jmbsvicetto Exp $

inherit eutils

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

src_compile() {
	emake || die "Make failure"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	chmod 04755 "${D}/usr/libexec/rmake/chroothelper"
	for x in "${D}/var/{rmake,{log,lib,run}/rmake}" "${D}/{etc,srv}/rmake"; do
		mkdir -p $x
		chown rmake:rmake $x
		touch ${x}/.keep
	done
	chmod 700 "${D}/var/rmake"
	# replace with updstream-provided in next release... see
	# https://issues.rpath.com/browse/RMK-242
	doinitd "${FILESDIR}/rmake"
}

pkg_setup() {
	enewgroup rmake
	enewgroup rmake-chroot
	enewuser rmake -1 -1 /srv/rmake "rmake"
	enewuser rmake-chroot -1 -1 / "rmake-chroot"
}
