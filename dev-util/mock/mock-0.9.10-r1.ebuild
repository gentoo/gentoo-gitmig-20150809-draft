# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mock/mock-0.9.10-r1.ebuild,v 1.2 2009/03/27 18:06:43 mr_bones_ Exp $

DESCRIPTION="Mock creates chroots and builds packages in them for Fedora and
RedHat."
HOMEPAGE="http://fedoraproject.org/wiki/Projects/Mock"
SRC_URI="https://fedorahosted.org/mock/attachment/wiki/MockTarballs/mock-${PV}.tar.gz?format=raw -> mock-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

EAPI="2"

DEPEND=""
RDEPEND="sys-apps/yum
	dev-python/decoratortools"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	if ! [[ $(grep -q mock /etc/group && echo $?) ]]; then
		einfo "Creating group 'mock'"
		groupadd mock
	fi
}
