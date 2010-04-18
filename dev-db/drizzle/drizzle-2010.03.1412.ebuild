# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/drizzle/drizzle-2010.03.1412.ebuild,v 1.3 2010/04/18 16:39:22 mr_bones_ Exp $

EAPI=2

inherit flag-o-matic libtool autotools eutils pam

DESCRIPTION="Database optimized for Cloud and Net applications"
HOMEPAGE="http://drizzle.org"
SRC_URI="http://launchpad.net/drizzle/cherry/2010-03-29/+download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug tcmalloc doc memcache curl pam gearman +md5"

# upstream bug #499911
RESTRICT="memcache? ( test ) !curl? ( test )"

# for libdrizzle version, check m4/pandora*, PANDORA_LIBDRIZZLE_RECENT
RDEPEND="tcmalloc? ( dev-util/google-perftools )
		>=dev-db/libdrizzle-0.8
		sys-libs/readline
		sys-apps/util-linux
		dev-libs/libpcre
		>=dev-libs/libevent-1.4
		>=dev-libs/protobuf-2.1.0
		gearman? ( >=sys-cluster/gearmand-0.12 )
		pam? ( sys-libs/pam )
		curl? ( net-misc/curl )
		memcache? ( >=dev-libs/libmemcached-0.39 )
		md5? ( >=dev-libs/libgcrypt-1.4.2 )
		>=dev-libs/boost-1.32"
DEPEND="${RDEPEND}
		dev-util/gperf
		doc? ( app-doc/doxygen )
		>=dev-util/boost-build-1.32"

pkg_setup() {
	enewuser drizzle -1 -1 /dev/null nogroup
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2010.03.1412-ggdb3-fix.patch"
	# disable in release after 1412
	epatch "${FILESDIR}/${PN}-2009.12.1240-nolint.patch"

	AT_M4DIR="m4" eautoreconf
	elibtoolize
}

src_configure() {
	local myconf=

	if use debug; then
		append-flags -DDEBUG
	fi

	# while I applaud upstreams goal of 0 compiler warnings
	# the 1412 release didn't achieve it.
	append-flags -Wno-error

	# disable-all gets rid of automagic dep
	econf \
		--disable-all \
		--disable-static \
		--disable-dependency-tracking \
		--disable-mtmalloc \
		--with-debug=$(use debug && echo yes || echo no) \
		$(use_enable tcmalloc) \
		$(use_enable memcache libmemcached) \
		$(use_enable gearman libgearman) \
		$(use_with curl auth-http-plugin) \
		$(use_with pam auth-pam-plugin) \
		$(use_with md5 md5-plugin) \
		$(use_with gearman gearman_udf-plugin) \
		$(use_with gearman logging_gearman-plugin) \
		$(use_with memcache memcache_functions-plugins) \
		--with-logging_stats \
		--without-hello-world-plugin \
		${myconf}

	# upstream TODO:
	# --without-all \
	# broken atm
	#$(use_with memcache memcache_stats-plugins) \
}

src_compile() {
	emake || die "build failed"

	if use doc; then
		emake doxygen || die "doxygen failed"
	fi
}

# 5-10 min eta
src_test() {
	# If you want to turn off a test, rename to suffix of .DISABLED
	# Explicitly allow parallel make check
	emake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README || die

	find "${D}" -name '*.la' -delete || die

	if use doc; then
		docinto apidoc
		pushd docs/html
		dohtml -r .
		popd
	fi

	newinitd "${FILESDIR}"/drizzle.init.d drizzled || die
	newconfd "${FILESDIR}"/drizzle.conf.d drizzled || die

	if ! use gearman; then
		sed -i -e '/need gearmand/d' "${D}"/etc/init.d/drizzled \
			|| die "unable to sed init script (gearman)"
	fi

	if ! use memcache; then
		sed -i -e '/need memcached/d' "${D}"/etc/init.d/drizzled \
			|| die "unable to sed init script (memcache)"
	fi

	keepdir /var/run/drizzle || die
	keepdir /var/log/drizzle || die
	keepdir /var/lib/drizzle/drizzled || die
	keepdir /etc/drizzle || die

	fperms 0755 /var/run/drizzle || die
	fperms 0755 /var/log/drizzle || die
	fperms -R 0700 /var/lib/drizzle || die

	fowners drizzle:nogroup /var/run/drizzle || die
	fowners drizzle:nogroup /var/log/drizzle || die
	fowners -R drizzle:nogroup /var/lib/drizzle || die

	pamd_mimic system-auth drizzle auth account session
}
