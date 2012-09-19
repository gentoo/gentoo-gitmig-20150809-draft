# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/drizzle/drizzle-7.2.3.ebuild,v 1.1 2012/09/19 05:25:54 flameeyes Exp $

EAPI=4

inherit flag-o-matic libtool autotools eutils pam user versionator

DESCRIPTION="Database optimized for Cloud and Net applications"
HOMEPAGE="http://drizzle.org"
SRC_URI="http://launchpad.net/drizzle/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug tcmalloc doc memcache curl pam gearman +md5 ldap"

RDEPEND="tcmalloc? ( dev-util/google-perftools )
		sys-libs/readline
		sys-apps/util-linux
		dev-libs/libpcre
		dev-libs/openssl
		>=dev-libs/libevent-1.4
		>=dev-libs/protobuf-2.1.0
		gearman? ( >=sys-cluster/gearmand-0.12 )
		pam? ( sys-libs/pam )
		curl? ( net-misc/curl )
		memcache? ( >=dev-libs/libmemcached-0.39 )
		md5? ( >=dev-libs/libgcrypt-1.4.2 )
		>=dev-libs/boost-1.32
		ldap? ( net-nds/openldap )
		!dev-db/libdrizzle"

DEPEND="${RDEPEND}
		sys-devel/gettext
		dev-util/intltool
		dev-util/gperf
		sys-devel/flex
		doc? ( app-doc/doxygen )
		>=dev-util/boost-build-1.32"

pkg_setup() {
	enewuser drizzle -1 -1 /dev/null nogroup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libtool.patch
	epatch "${FILESDIR}"/${P}+automake-1.12.patch
	eautoreconf
}

src_configure() {
	local myconf=

	if use debug; then
		append-cppflags -DDEBUG
	fi

	# while I applaud upstreams goal of 0 compiler warnings
	# the 1412 release didn't achieve it.
	append-flags -Wno-error

	# NOTE disable-all and without-all no longer recognized options
	# NOTE using --enable on some plugins can cause test failures.
	# --with should be used instead. A discussion about this here:
	# https://bugs.launchpad.net/drizzle/+bug/598659
	# TODO (upstream)
	# $(use_with memcache memcached-stats-plugin) \
	# $(use_with memcache memcached-functions-plugin) \

	econf \
		--disable-static \
		--disable-dependency-tracking \
		--disable-mtmalloc \
		--without-hello-world-plugin \
		--disable-rabbitmq-plugin --without-rabbitmq-plugin \
		--disable-zeromq-plugin --without-zeromq-plugin \
		--with-auth-test-plugin \
		--with-auth-file-plugin \
		--with-simple-user-policy-plugin \
		--enable-logging-stats-plugin \
		--with-logging-stats-plugin \
		--enable-console-plugin \
		$(use_enable tcmalloc) \
		$(use_enable memcache libmemcached) \
		$(use_enable gearman libgearman) \
		$(use_enable ldap libldap) \
		$(use_with curl auth-http-plugin) \
		$(use_with pam auth-pam-plugin) \
		$(use_with md5 md5-plugin) \
		$(use_with gearman gearman-udf-plugin) \
		$(use_with gearman logging-gearman-plugin) \
		$(use_with ldap auth-ldap-plugin) \
		${myconf}
}

src_compile() {
	emake V=1 all $(use doc && echo doxygen)
}

# currently not working as of 7.2.3
RESTRICT=test

src_test() {
	if [[ ${EUID} == 0 ]]; then
		eerror "You cannot run tests as root."
		eerror "Please enable FEATURES=userpriv before proceeding."
		return 1
	fi

	# If you want to turn off a test, rename to suffix of .DISABLED
	# Explicitly allow parallel make check
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README

	find "${D}" -name '*.la' -delete || die

	if use doc; then
		docinto apidoc
		pushd docs/html
		dohtml -r .
		popd
	fi

	newinitd "${FILESDIR}"/drizzle.init.d drizzled
	newconfd "${FILESDIR}"/drizzle.conf.d drizzled

	if ! use gearman; then
		sed -i -e '/need gearmand/d' "${D}"/etc/init.d/drizzled \
			|| die "unable to sed init script (gearman)"
	fi

	if ! use memcache; then
		sed -i -e '/need memcached/d' "${D}"/etc/init.d/drizzled \
			|| die "unable to sed init script (memcache)"
	fi

	keepdir /var/run/drizzle
	keepdir /var/log/drizzle
	keepdir /var/lib/drizzle/drizzled
	keepdir /etc/drizzle

	fperms 0755 /var/run/drizzle
	fperms 0755 /var/log/drizzle
	fperms -R 0700 /var/lib/drizzle

	fowners drizzle:nogroup /var/run/drizzle
	fowners drizzle:nogroup /var/log/drizzle
	fowners -R drizzle:nogroup /var/lib/drizzle

	pamd_mimic system-auth drizzle auth account session
}
