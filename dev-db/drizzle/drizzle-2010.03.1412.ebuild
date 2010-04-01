# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/drizzle/drizzle-2010.03.1412.ebuild,v 1.1 2010/04/01 15:01:51 flameeyes Exp $

EAPI=2

inherit flag-o-matic libtool autotools eutils pam

DESCRIPTION="Database optimized for Cloud and Net applications"
HOMEPAGE="http://drizzle.org"
SRC_URI="http://launchpad.net/drizzle/cherry/2010-03-29/+download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug tcmalloc doc memcache curl pam gearman +md5"

# upstream bug #499911
RESTRICT="memcache? ( test ) !curl? ( test )"

RDEPEND="tcmalloc? ( dev-util/google-perftools )
		dev-db/libdrizzle
		sys-libs/readline
		sys-apps/util-linux
		dev-libs/libpcre
		dev-libs/libevent
		dev-libs/protobuf
		gearman? ( sys-cluster/gearmand )
		pam? ( sys-libs/pam )
		curl? ( net-misc/curl )
		memcache? ( dev-libs/libmemcached )
		md5? ( dev-libs/libgcrypt )"
DEPEND="${RDEPEND}
		dev-util/gperf
		doc? ( app-doc/doxygen )"

pkg_setup() {
	elog "This is a work-in-progress ebuild, some features will require"
	elog "manual configuration and others aren't fleshed out just yet."
	elog "Use it at your risk."

	enewuser drizzle -1 -1 /dev/null nogroup
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2009.12.1240-nolint.patch"
	AT_M4DIR="m4" eautoreconf
	elibtoolize
}

src_configure() {
	local myconf=

	if use debug; then
		append-flags -DDEBUG
	fi

	econf \
		--disable-static \
		--disable-dependency-tracking \
		--disable-mtmalloc \
		$(use_enable tcmalloc) \
		$(use_enable memcache libmemcached) \
		$(use_enable gearman libgearman) \
		$(use_with curl auth-http-plugin) \
		$(use_with pam auth-pam-plugin) \
		$(use_with md5 md5-plugin) \
		--without-hello-world-plugin \
		${myconf}
}

src_compile() {
	emake || die "build failed"

	if use doc; then
		emake doxygen || die "doxygen failed"
	fi
}

src_test() {
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
