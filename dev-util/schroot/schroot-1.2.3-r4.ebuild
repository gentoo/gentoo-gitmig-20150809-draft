# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/schroot/schroot-1.2.3-r4.ebuild,v 1.3 2009/11/26 17:18:50 maekke Exp $

EAPI="2"

inherit autotools base pam

DESCRIPTION="Utility to execute commands in a chroot environment"
HOMEPAGE="http://packages.debian.org/source/sid/schroot"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+dchroot debug doc nls test"

COMMON_DEPEND="
	>=dev-libs/boost-1.34.0
	dev-libs/lockdev
	sys-libs/pam
"

DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )
	test? ( >=dev-util/cppunit-1.10.0 )
"
RDEPEND="${COMMON_DEPEND}
	sys-apps/debianutils
	dchroot? ( !dev-util/dchroot )
	nls? ( virtual/libintl )
"

PATCHES=(
	"${FILESDIR}/${P}-autotools.patch"
	"${FILESDIR}/${P}-tests.patch"
)

src_prepare() {
	base_src_prepare

	if use test; then
		# Fix bug where aclocal doesn't find cppunit.m4 from the system...
		ln -s /usr/share/aclocal/cppunit.m4 m4/
	else
		# Don't depend on cppunit unless we are testing
		sed -i '/AM_PATH_CPPUNIT/s/^.*$/:/' configure.ac
	fi

	export AT_M4DIR=m4
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable dchroot) \
		$(use_enable dchroot dchroot-dsa) \
		$(use_enable debug) \
		$(use_enable nls) \
		--enable-shared \
		--disable-static \
		--localstatedir=/var
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

	rm -f "${D}"/etc/pam.d/schroot
	pamd_mimic_system schroot auth account session

	# Remove *.la files
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}
