# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gatt/gatt-9999.ebuild,v 1.4 2009/06/18 11:30:48 gentoofan23 Exp $

inherit eutils subversion autotools

ESVN_REPO_URI="svn://80.108.115.144/gatt/trunk"
ESVN_PROJECT="Gatt"

DESCRIPTION="Gentoo Arch Testing Tool"
HOMEPAGE="http://gatt.sourceforge.net/
	http://www.gentoo.org/proj/en/base/x86/at.xml
	http://www.gentoo.org/proj/en/base/ppc/AT/index.xml
	http://www.gentoo.org/proj/en/base/amd64/at/index.xml
	http://www.gentoo.org/proj/en/base/alpha/AT/index.xml"
SRC_URI=""

LICENSE="GPL-2 GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc libpaludis"

RDEPEND=">=dev-libs/boost-1.33.1
	>=dev-cpp/libthrowable-1.1.0
	www-client/pybugz
	libpaludis? ( >=sys-apps/paludis-0.26.0_alpha9 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	ewarn
	ewarn "Gatt is targeted at Gentoo developers, arch-testers and power users. Do"
	ewarn "by no means use it if you are new to Gentoo. You have been warned!"
	ewarn
	ewarn "This is a Subversion snapshot, so no functionality is"
	ewarn "guaranteed!	Better not use it as root for now and backup"
	ewarn "at least your data in /etc/portage/!"
	elog
	elog "There are several files that explain usage of Gatt: README, TUTORIAL,"
	elog "and gatt.info (best read in that order)"
	if use libpaludis && ! built_with_use sys-apps/paludis portage; then
		ewarn "You either have to emerge Paludis with USE=portage enabled or configure"
		ewarn "it properly before using Gatt with it"
	fi
}

src_unpack() {
	subversion_src_unpack
	eautoreconf
}

src_compile() {
	econf $(use_enable libpaludis) || die "econf failed"
	emake || die "emake failed"
	use doc && doxygen
}
src_install() {
	emake DESTDIR="${D}" install || die "installing ${PF} failed"
	dodoc README NEWS AUTHORS ChangeLog doc/TUTORIAL
	newdoc .todo TODO

	if use doc; then
		dohtml doc/html/*
	fi
}
