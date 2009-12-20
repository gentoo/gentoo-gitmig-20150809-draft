# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gearmand/gearmand-0.11-r1.ebuild,v 1.1 2009/12/20 19:19:34 flameeyes Exp $

EAPI=2

inherit flag-o-matic

DESCRIPTION="Generic framework to farm out work to other machines"
HOMEPAGE="http://www.gearman.org/"
SRC_URI="http://launchpad.net/gearmand/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug tcmalloc +memcache"

RDEPEND="dev-libs/libevent
	|| ( >=sys-apps/util-linux-2.16 <sys-libs/e2fsprogs-libs-1.41.8 )
	tcmalloc? ( dev-util/google-perftools )
	memcache? ( dev-libs/libmemcached )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewuser gearmand -1 -1 /dev/null nogroup
}

src_configure() {
	local myconf=

	# Don't ever use --enable-assert since configure.ac is broken, and
	# only does --disable-assert correctly.
	 if use debug; then
		# Since --with-debug would turn off optimisations as well as
		# enabling debug, we just enable debug through the
		# preprocessor then.
		append-flags -DDEBUG

	# Right now disabling asserts break the code, so never disable
	# them as it is.
	#else
	#	myconf="${myconf} --disable-assert"
	fi

	# TODO once there's a drizzle/librizzle ebuild, add drizzle to iuse
	# TODO new compile options for queue storage: libsqlite,libpq,libdrizzle
	# TODO mtmalloc, umem, dtrace - all of this solaris stuff only?
	# TODO libmemcached pulls memcached. Is this correct?
	econf \
		--disable-dependency-tracking \
		$(use_enable tcmalloc) \
		$(use_enable memcache libmemcached) \
		--disable-mtmalloc \
		--disable-libsqlite3 \
		--disable-libdrizzle \
		--disable-libpq \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README AUTHORS ChangeLog || die "dodoc failed"

	newinitd "${FILESDIR}"/gearmand.init.d gearmand || die
	newconfd "${FILESDIR}"/gearmand.conf.d gearmand || die

	keepdir /var/run/gearmand || die
	fperms 0755 /var/run/gearmand || die
	fowners gearmand:nogroup /var/run/gearmand || die

	keepdir /var/log/gearmand || die
	fperms 0755 /var/log/gearmand || die
	fowners gearmand /var/log/gearmand || die
}
