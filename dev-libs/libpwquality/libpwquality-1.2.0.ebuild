# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpwquality/libpwquality-1.2.0.ebuild,v 1.2 2012/08/24 22:00:37 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="python? 2:2.7"

inherit eutils multilib python

DESCRIPTION="Library for password quality checking and generating random passwords"
HOMEPAGE="https://fedorahosted.org/libpwquality/"
SRC_URI="https://fedorahosted.org/releases/l/i/${PN}/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pam python static-libs"

RDEPEND=">=sys-libs/cracklib-2.8
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	econf \
		$(use_enable pam) \
		$(use_enable python python-bindings) \
		$(use_enable static-libs static)
}

src_install() {
	default
	# prune_libtool_files doesn't remove it...
	use pam && rm -v "${ED}usr/$(get_libdir)/security/pam_pwquality.la"
	prune_libtool_files
}
