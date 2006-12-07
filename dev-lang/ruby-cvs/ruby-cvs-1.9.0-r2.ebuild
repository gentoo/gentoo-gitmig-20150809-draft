# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby-cvs/ruby-cvs-1.9.0-r2.ebuild,v 1.6 2006/12/07 19:42:11 pclouds Exp $

IUSE="socks5 tk doc threads"

inherit flag-o-matic cvs

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI=""

LICENSE="Ruby"
SLOT="1.9"
KEYWORDS="~alpha ~hppa ~ia64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	dev-util/gperf
	socks5? ( >=net-proxy/dante-1.1.13 )
	tk?  ( dev-lang/tk )
	sys-apps/findutils
	>=dev-ruby/ruby-config-0.3.1"
RDEPEND="${DEPEND}
	!=dev-lang/ruby-${SLOT}*"
PROVIDE="virtual/ruby"

ECVS_SERVER="cvs.ruby-lang.org:/src"
ECVS_MODULE="ruby"
ECVS_AUTH="pserver"
ECVS_PASS="anonymous"
ECVS_UP_OPTS="-dP -rHEAD"
ECVS_CO_OPTS="-rHEAD"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	filter-flags -fomit-frame-pointer

	local ruby_version=`gawk '$2=="RUBY_VERSION" {print $3}' version.h | tr -d \"`
	if [ "${PV}" != "${ruby_version}" ]; then
		die "version mismatch"
	fi

	# Socks support via dante
	if ! use socks5 ; then
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		unset SOCKS_SERVER
	fi

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		CFLAGS="${CFLAGS} -DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
		export CFLAGS
	fi

	autoconf || die "autoconf failed"

	econf --program-suffix=${SLOT/./} --enable-shared \
		$(use_enable socks5 socks) \
		$(use_enable doc install-doc) \
		$(use_enable threads pthread) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	LD_LIBRARY_PATH=${D}/usr/lib
	RUBYLIB=${D}/usr/lib/ruby/${SLOT}
	for d in $(find ${S}/ext -type d) ; do
		RUBYLIB="${RUBYLIB}:$d"
	done
	export LD_LIBRARY_PATH RUBYLIB

	make DESTDIR=${D} install || die "make install failed"

	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby${SLOT/./}.so.${PV} /usr/lib/libruby.so.${PV}

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

pkg_postinst() {

	if [ ! -n "$(readlink /usr/bin/ruby)" ] ; then
		/usr/sbin/ruby-config ruby${SLOT/./}
	fi
	einfo
	einfo "You can change the default ruby interpreter by /usr/sbin/ruby-config"
	einfo
}

pkg_postrm() {

	if [ ! -n "$(readlink /usr/bin/ruby)" ] ; then
		/usr/sbin/ruby-config ruby${SLOT/./}
	fi
}
