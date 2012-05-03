# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-4.0.0_alpha17.ebuild,v 1.2 2012/05/03 04:06:33 jdhore Exp $

EAPI=4

inherit eutils confutils python waf-utils versionator

MY_PV="${PV/_alpha/alpha}"
MY_P="${PN}-${MY_PV}"

if [ "${PV}" = "4.9999" ]; then
	EGIT_REPO_URI="git://git.samba.org/samba.git"
	inherit git-2
else
	SRC_URI="mirror://samba/samba4/${MY_P}.tar.gz"
fi

DESCRIPTION="Samba Server component"
HOMEPAGE="http://www.samba.org/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl addns ads aio avahi client cluster cups debug fulltest gnutls iprint
krb5 ldap pam quota swat syslog winbind"

RDEPEND="dev-libs/popt
	sys-libs/readline
	virtual/libiconv
	>=dev-lang/python-2.4.2
	dev-python/subunit
	>=app-crypt/heimdal-1.5[-ssl]
	>=sys-libs/tdb-1.2.9[python]
	>=sys-libs/ldb-1.1.2
	>=sys-libs/talloc-2.0.6[python]
	>=sys-libs/tevent-0.9.14
	sys-libs/zlib
	ads? ( client? ( net-fs/cifs-utils[ads] ) )
	client? ( net-fs/cifs-utils )
	cluster? ( >=dev-db/ctdb-1.0.114_p1 )
	ldap? ( net-nds/openldap )
	gnutls? ( >=net-libs/gnutls-1.4.0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="mirror"

S="${WORKDIR}/${MY_P}"

CONFDIR="${FILESDIR}/$(get_version_component_range 1-2)"

WAF_BINARY="${S}/buildtools/bin/waf"

pkg_setup() {
	confutils_use_depend_all fulltest test

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	cd "${WORKDIR}/${MY_P}" && epatch "${CONFDIR}"/com_err.patch
}

src_configure() {
	local myconf=''
	if use "debug"; then
		myconf="${myconf} --enable-developer"
	fi
	if use "cluster"; then
		myconf="${myconf} --with-ctdb-dir=/usr"
	fi
	myconf="${myconf} \
		--enable-fhs \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-rpath \
		--disable-rpath-install \
		--nopyc \
		--nopyo \
		--bundled-libraries=NONE \
		--builtin-libraries=replace,ccan \
		$(use_with addns dnsupdate) \
		$(use_with acl) \
		$(use_with ads) \
		$(use_with aio aio-support) \
		$(use_enable avahi) \
		$(use_with cluster cluster-support) \
		$(use_enable cups) \
		$(use_enable gnutls) \
		$(use_enable iprint) \
		$(use_with krb5) \
		$(use_with ldap) \
		$(use_with pam) \
		$(use_with pam pam_smbpass) \
		$(use_with quota) \
		$(use_with syslog) \
		$(use_with swat) \
		$(use_with winbind)"
	waf-utils_src_configure ${myconf}
}

src_install() {
	waf-utils_src_install

	newinitd "${CONFDIR}/samba4.initd" samba || die "newinitd failed"

	#remove conflicting file for tevent profided by sys-libs/tevent
	find "${D}" -type f -name "_tevent.so" -exec rm -f {} \;
}

src_test() {
	local extra_opts=""
	use fulltest || extra_opts+="--quick"
	"${WAF_BINARY}" test ${extra_opts} || die "test failed"
}

pkg_postinst() {
	# Optimize the python modules so they get properly removed
	python_mod_optimize "${PN}"

	einfo "See http://wiki.samba.org/index.php/Samba4/HOWTO for more"
	einfo "information about samba 4."

	# Warn that it's an alpha
	ewarn "Samba 4 is an alpha and therefore not considered stable. It's only"
	ewarn "meant to test and experiment and definitely not for production"
}

pkg_postrm() {
	# Clean up the python modules
	python_mod_cleanup "${PN}"
}
