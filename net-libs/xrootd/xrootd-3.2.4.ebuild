# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/xrootd/xrootd-3.2.4.ebuild,v 1.1 2012/09/29 23:38:58 bicatali Exp $

EAPI=4

inherit cmake-utils eutils

DURI="http://xrootd.slac.stanford.edu/doc/prod"

DESCRIPTION="Extended ROOT remote file server"
HOMEPAGE="http://xrootd.org/"
SRC_URI="${HOMEPAGE}/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fuse kerberos perl readline ssl"

RDEPEND="!<sci-physics/root-5.32[xrootd]
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	kerberos? ( virtual/krb5 )
	perl? (
		dev-lang/perl
		readline? ( dev-perl/Term-ReadLine-Perl )
	)
	readline? ( sys-libs/readline )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[dot] )
	perl? ( dev-lang/swig )"

pkg_setup() {
	enewgroup xrootd
	enewuser xrootd -1 -1 "${EPREFIX}"/var/spool/xrootd xrootd
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable fuse)
		$(cmake-utils_use_enable kerberos KRB5)
		$(cmake-utils_use_enable perl)
		$(cmake-utils_use_enable readline)
		$(cmake-utils_use_enable ssl CRYPTO)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && doxygen Doxyfile
}

src_install() {
	cmake-utils_src_install

	# base configs
	insinto /etc/xrootd
	doins packaging/common/*.cfg

	# create aux dirs and correct permissions so that xrootd
	# will be happy as a non-priviledged user
	fowners root:xrootd "${EPREFIX}"/etc/xrootd
	keepdir "${EPREFIX}"/var/log/xrootd
	keepdir "${EPREFIX}"/var/run/xrootd
	keepdir "${EPREFIX}"/var/spool/xrootd
	fowners xrootd:xrootd "${EPREFIX}"/var/{log,run,spool}/xrootd

	local i
	for i in cmsd frm_purged frm_xfrd xrootd; do
		newinitd "${FILESDIR}"/${i}.initd ${i}
	done
	# all daemons MUST use single master config file
	newconfd "${FILESDIR}"/xrootd.confd xrootd

	dodoc docs/ReleaseNotes.txt
	use doc && dohtml -r doxydoc/html/*
}
