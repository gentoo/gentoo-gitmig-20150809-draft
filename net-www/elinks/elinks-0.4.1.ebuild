# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/elinks/elinks-0.4.1.ebuild,v 1.2 2003/01/22 17:28:48 wwoods Exp $

DESCRIPTION="Advanced and well-established text-mode web browser"
HOMEPAGE="http://elinks.or.cz"
SRC_URI="http://elinks.or.cz/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="virtual/glibc
	>=sys-apps/bzip2-1.0.2*
	>=dev-libs/expat-1.95.4*
	>=sys-apps/portage-2.0.45-r3
	ssl? ( >=dev-libs/openssl-0.9.6g )
	X? ( >=x11-base/xfree-4.2.1* )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	lua? ( >=dev-lang/lua-4.0 )
	gpm? ( >=sys-libs/ncurses-5.2* >=sys-libs/gpm-1.20.0-r5 )"

RDEPEND="virtual/glibc
	>=sys-apps/bzip2-1.0.2*
	>=dev-libs/expat-1.95.4*
	>=sys-apps/gzip-1.3.3
	ssl? ( >=dev-libs/openssl-0.9.6g )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	lua? ( >=dev-lang/lua-4.0 )
	gpm? ( >=sys-libs/ncurses-5.2* >=sys-libs/gpm-1.20.0-r5 )
	X? ( >=x11-base/xfree-4.2.1* )"

IUSE="gpm zlib ssl ipv6 X nls lua"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	bzcat ${FILESDIR}/elinks.conf.bz2 >elinks.conf
}

src_compile() {
	if ! use nls; then
		# Build with only english support
		echo 'english' > intl/index.txt
		cd intl && ./gen-intl && cd ${S}
	fi

	# NOTE about GNUTSL SSL support (from the README -- 25/12/2002)
	# As GNUTLS is not yet 100% stable and its support in ELinks is not so well
	# tested yet, it's recommended for users to give a strong preference to OpenSSL whenever possible.

	econf	`use_with gpm` \
		`use_with zlib` \
		`use_with ssl openssl` \
		`use_with X x` \
		`use_enable ipv6` \
		`use_with lua` \
		--enable-leds || die "configure problem"
		
	emake || die "compile problem"
}

src_install() {
	dobin src/elinks
	doman elinks*.[0-9]

	insopts -m 644 ; insinto /etc/elinks
	doins ${WORKDIR}/elinks.conf
	newins contrib/keybind-full.conf keybind-full.sample
	newins contrib/keybind.conf keybind.conf.sample
	
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README SITES THANKS TODO doc/*.*
	docinto contrib ; dodoc contrib/{README,completion.tcsh,colws.diff,elinks[-.]vim*}
	docinto contrib/lua ; dodoc contrib/lua/{*.lua,elinks-remote}
	docinto contrib/conv ; dodoc contrib/conv/*.*
}

pkg_postinst() {
	einfo "This ebuild provides a default config for Elinks."
	einfo "Please check /etc/elinks/elinks.conf"
	echo
	einfo "You may want to convert your html.cfg and links.cfg of Links or older Elinks versions"
	einfo "to the new Elinks elinks.conf using /usr/share/doc/${P}/contrib/conv/conf-links2elinks.pl"
	echo
	einfo "Please have a look at /etc/elinks/keybind-full.sample and"
	einfo "/etc/elinks/keybind.conf.sample for some bindings examples."
}
