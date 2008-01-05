# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bb/bb-1.3.0_rc1.ebuild,v 1.1 2008/01/05 22:03:23 jokey Exp $

inherit eutils versionator

MY_P="${PN}-$(get_version_component_range 1-2)$(get_version_component_range 4-4)"

DESCRIPTION="Demonstration program for visual effects of aalib"
HOMEPAGE="http://aa-project.sourceforge.net/"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mikmod"

DEPEND="media-libs/aalib
	mikmod? ( media-libs/libmikmod )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-noattr.patch" || die "epatch failed"
}

src_install() {
	newbin bb bb-aalib || die "renaming bb binary failed"
	newman bb.1 bb-aalib.1 || die "renaming bb manpage failed"
	insinto /usr/share/bb
	doins bb.s3m bb2.s3m bb3.s3m
}

pkg_postinst() {
	elog "bb binary has been renamed to bb-aalib to avoid a naming conflict with busybox."
}
