# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti-instance-image/ganeti-instance-image-0.4.ebuild,v 1.2 2011/01/22 20:09:49 ramereth Exp $

EAPI=2

inherit eutils

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://git.osuosl.org/${PN}.git"
	EGIT_BRANCH="master"
	inherit git autotools
else
	SRC_URI="http://ftp.osuosl.org/pub/osl/ganeti-instance-image/${P}.tar.gz"
fi

DESCRIPTION="Scripts to build out CD or image based VMs using Ganeti"
HOMEPAGE="http://code.osuosl.org/projects/ganeti-image"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="app-arch/dump
	>=app-emulation/ganeti-2.0.3
	|| ( >=sys-apps/coreutils-6.10-r1 sys-apps/mktemp )
	sys-apps/util-linux
	sys-fs/multipath-tools
	sys-fs/e2fsprogs"

src_prepare() {
	if [[ ${PV} == "9999" ]]; then
		eautoreconf
	fi
}

src_configure() {
	econf --with-defaults-dir=/etc/ganeti
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc README NEWS ChangeLog
	insinto /etc/ganeti
	newins defaults ${PN}
}
