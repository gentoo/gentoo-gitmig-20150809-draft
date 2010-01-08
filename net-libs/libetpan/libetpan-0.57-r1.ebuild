# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libetpan/libetpan-0.57-r1.ebuild,v 1.1 2010/01/08 21:27:03 grobian Exp $

DESCRIPTION="A portable, efficient middleware for different kinds of mail access."
HOMEPAGE="http://libetpan.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="berkdb debug gnutls ipv6 liblockfile sasl ssl"

DEPEND="berkdb? ( sys-libs/db )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )
	sasl? ( dev-libs/cyrus-sasl )
	liblockfile? ( net-libs/liblockfile )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# temp fix for bug #286620, also look for db-4.8, upstream will likely fix
	# this in their next release
	sed -i -e '/db-4.7 db-4.6/s/db-4.7/db-4.8 db-4.7/' configure || die
}

src_compile() {
	local sslconf

	if use ssl; then
		if use gnutls; then
			sslconf="--with-gnutls --without-openssl"
		else
			sslconf="--without-gnutls --with-openssl"
		fi
	else
		if use gnutls; then
			sslconf="--with-gnutls --without-openssl"
		else
			sslconf="--without-gnutls --without-openssl"
		fi
	fi

	# in Prefix emake uses SHELL=${BASH}, export CONFIG_SHELL to the same so
	# libtool recognises it as valid shell (bug #300211)
	use prefix && export CONFIG_SHELL=${BASH}
	# The configure script contains an error, in that it doesn't check the
	# argument of --enable-{debug,optim}, hence --disable-debug results in
	# --enable-debug=no, which isn't checked and debugging flags are blindly
	# injected.  So, avoid passing --disable-debug when we don't need it.
	econf \
		$(use debug && echo --enable-debug) \
		$(use_enable berkdb db) \
		$(use_with sasl) \
		$(use_enable ipv6) \
		$(use_enable liblockfile lockfile) \
		${sslconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS ChangeLog
}

pkg_postinst() {
	echo
	ewarn "The soname for libetpan has changed after libetpan-0.53."
	ewarn "If you have upgraded from that or earlier version, it is recommended to run"
	ewarn "revdep-rebuild to fix any linking errors caused by this change."
	echo
}
