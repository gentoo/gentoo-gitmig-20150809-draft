# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/schroot/schroot-1.4.0.ebuild,v 1.2 2010/02/13 22:29:07 abcd Exp $

EAPI="2"
WANT_AUTOMAKE="1.11"

inherit autotools base pam

DESCRIPTION="Utility to execute commands in a chroot environment"
HOMEPAGE="http://packages.debian.org/source/sid/schroot"
SRC_URI="mirror://debian/pool/main/${PN::1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dchroot debug doc lvm nls pam test"

COMMON_DEPEND="
	>=dev-libs/boost-1.39.0
	dev-libs/lockdev
	>=sys-apps/util-linux-2.16
	lvm? ( sys-fs/lvm2 )
	pam? ( sys-libs/pam )
"

DEPEND="${COMMON_DEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
	nls? ( sys-devel/gettext )
	test? ( >=dev-util/cppunit-1.10.0 )
"
RDEPEND="${COMMON_DEPEND}
	sys-apps/debianutils
	dchroot? ( !sys-apps/dchroot )
	nls? ( virtual/libintl )
"

PATCHES=(
	"${FILESDIR}/${P}-tests.patch"
)

src_prepare() {
	base_src_prepare

	# Don't depend on cppunit unless we are testing
	use test || sed -i '/AM_PATH_CPPUNIT/d' configure.ac

	echo -e "Package: ${PN}\nVersion: ${PV}" > VERSION

	eautoreconf
}

src_configure() {
	root_tests=no
	use test && (( EUID == 0 )) && root_tests=yes
	econf \
		$(use_enable doc doxygen) \
		$(use_enable dchroot) \
		$(use_enable dchroot dchroot-dsa) \
		$(use_enable debug) \
		$(use_enable lvm lvm-snapshot) \
		$(use_enable nls) \
		$(use_enable pam) \
		--enable-block-device \
		--enable-loopback \
		--enable-uuid \
		--enable-root-tests=$root_tests \
		--enable-shared \
		--disable-static \
		--localstatedir=/var \
		--with-bash-completion-dir=/usr/share/bash-completion
}

src_test() {
	if [[ $root_tests == yes && $EUID -ne 0 ]]; then
		ewarn "Disabling tests because you are no longer root"
		return 0
	fi
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/schroot.initd schroot || die "installation of init.d script failed"
	newconfd "${FILESDIR}"/schroot.confd schroot || die "installation of conf.d file failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "installation of docs failed"
	if use doc; then
		docinto html/sbuild
		dohtml doc/sbuild/html/* || die "installation of html docs failed"
		docinto html/schroot
		dohtml doc/schroot/html/* || die "installation of html docs failed"
	fi

	if use pam; then
		rm -f "${D}"/etc/pam.d/schroot
		pamd_mimic_system schroot auth account session
	fi

	# Remove *.la files
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
