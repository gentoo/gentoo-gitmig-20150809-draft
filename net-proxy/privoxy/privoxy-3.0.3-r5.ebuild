# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/privoxy/privoxy-3.0.3-r5.ebuild,v 1.1 2006/04/06 14:31:00 mrness Exp $

inherit toolchain-funcs eutils

HOMEPAGE="http://www.privoxy.org"
DESCRIPTION="A web proxy with advanced filtering capabilities for protecting privacy against internet junk."
SRC_URI="mirror://sourceforge/ijbswa/${P}-stable-src.tar.gz"

IUSE="pcre selinux zlib"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"

DEPEND="=sys-devel/autoconf-2.1*
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )"
RDEPEND="selinux? ( sec-policy/selinux-privoxy )
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )"

S="${WORKDIR}/${P}-stable"

pkg_setup() {
	enewgroup privoxy
	enewuser privoxy -1 -1 /etc/privoxy privoxy
}

src_unpack() {
	unpack ${A}

	# add gzip and zlib decompression
	use zlib && epatch "${FILESDIR}/${P}-zlib.patch"

	rm "${S}"/autom4te.cache/{output.0,requests,traces.0}

	sed -e 's:confdir .:confdir /etc/privoxy:' \
		-e 's:logdir .:logdir /var/log/privoxy:' \
		-e 's:logfile logfile:logfile privoxy.log:' \
		-i "${S}/config" || die "sed failed."
	sed -e 's:^\+set-image-blocker{pattern}:+set-image-blocker{blank}:' \
		-i "${S}/default.action.master" || die "sed 2 failed."
}

src_compile() {
	export WANT_AUTOCONF=2.1
	autoheader || die "autoheader failed"
	autoconf || die "autoconf failed"

	export CC=$(tc-getCC)
	econf \
		$(use_enable pcre dynamic-pcre) \
		$(use_enable zlib) \
		--sysconfdir=/etc/privoxy || die "econf failed"

	emake || die "make failed."
}

pkg_preinst() {
	pkg_setup
}

src_install () {
	diropts -m 0750 -g privoxy -o privoxy
	insopts -m 0640 -g privoxy -o privoxy

	keepdir /var/log/privoxy

	insinto /etc/privoxy
	doins default.action default.filter config standard.action trust user.action

	insinto /etc/privoxy/templates
	doins templates/*

	doman privoxy.1
	dodoc LICENSE README AUTHORS doc/text/faq.txt ChangeLog

	insopts -m 0644 -g root -o root
	diropts -m 0755 -g root -o root
	local i
	for i in developer-manual faq man-page user-manual ; do
		insinto "/usr/share/doc/${PF}/${i}"
		doins doc/webserver/"${i}"/*
	done

	insopts -m 0750 -g root -o root
	insinto /usr/sbin
	doins privoxy
	newinitd "${FILESDIR}/privoxy.rc7" privoxy
	insopts -m 0640
	insinto /etc/logrotate.d
	newins "${FILESDIR}/privoxy.logrotate" privoxy
}
