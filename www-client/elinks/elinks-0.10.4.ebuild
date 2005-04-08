# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/elinks/elinks-0.10.4.ebuild,v 1.1 2005/04/08 22:38:54 spock Exp $

IUSE="gpm zlib ssl ipv6 X lua guile"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Advanced and well-established text-mode web browser"
HOMEPAGE="http://elinks.or.cz"
SRC_URI="http://elinks.or.cz/download/${MY_P}.tar.bz2
	http://dev.gentoo.org/~spock/portage/distfiles/elinks-0.10.4.conf.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"

DEPEND="virtual/libc
	>=app-arch/bzip2-1.0.2*
	>=dev-libs/expat-1.95.4*
	>=sys-apps/portage-2.0.45-r3
	ssl? ( >=dev-libs/openssl-0.9.6g )
	X? ( virtual/x11 )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	lua? ( >=dev-lang/lua-4* )
	gpm? ( >=sys-libs/ncurses-5.2* >=sys-libs/gpm-1.20.0-r5 )
	guile? ( >=dev-util/guile-1.6.4-r1 )"
PROVIDE="virtual/textbrowser"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	mv "${PN}-0.10.4.conf" "${PN}.conf"
	sed -i \
		-e 's:CONFIG_256_COLORS=.*:CONFIG_256_COLORS=yes:' \
		-e 's:CONFIG_LEDS=.*:CONFIG_LEDS=yes:' \
		-e 's:CONFIG_HTML_HIGHLIGHT=.*:CONFIG_HTML_HIGHLIGHT=yes:' \
		${S}/features.conf
}

src_compile() {
	# NOTE about GNUTSL SSL support (from the README -- 25/12/2002)
	# As GNUTLS is not yet 100% stable and its support in ELinks is not so well
	# tested yet, it's recommended for users to give a strong preference to OpenSSL whenever possible.

	econf	--sysconfdir=/etc/elinks \
		--enable-leds \
		`use_with gpm` \
		`use_with zlib` \
		`use_with ssl openssl` \
		`use_with X x` \
		`use_enable ipv6` \
		`use_with lua` \
		`use_with guile`	|| die

	emake || die "compile problem"
}

src_install() {

	make DESTDIR="${D}" install || die

	insopts -m 644 ; insinto /etc/elinks
	doins ${WORKDIR}/elinks.conf
	newins contrib/keybind-full.conf keybind-full.sample
	newins contrib/keybind.conf keybind.conf.sample

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README SITES THANKS TODO doc/*.*
	docinto contrib ; dodoc contrib/{README,colws.diff,elinks[-.]vim*}
	insinto /usr/share/doc/${PF}/contrib/lua ; doins contrib/lua/{*.lua,elinks-remote}
	insinto /usr/share/doc/${PF}/contrib/conv ; doins contrib/conv/*.*
	insinto /usr/share/doc/${PF}/contrib/guile ; doins contrib/guile/*.scm
}

# disable it as the only test available is interactive..
src_test() {
	return 0
}

pkg_postinst() {
	einfo "This ebuild provides a default config for ELinks."
	einfo "Please check /etc/elinks/elinks.conf"
	einfo
	einfo "You may want to convert your html.cfg and links.cfg of"
	einfo "Links or older ELinks versions to the new ELinks elinks.conf"
	einfo "using /usr/share/doc/${PF}/contrib/conv/conf-links2elinks.pl"
	einfo
	einfo "Please have a look at /etc/elinks/keybind-full.sample and"
	einfo "/etc/elinks/keybind.conf.sample for some bindings examples."
	einfo
	einfo "If you have compiled ELinks with Guile support, you will have to"
	einfo "copy internal-hooks.scm and user-hooks.scm from"
	einfo "/usr/share/doc/${PF}/contrib/guile/ to ~/.elinks/"
	einfo
	einfo "You will have to set your TERM variable to 'xterm-256color'"
	einfo "to be able to use 256 colors in elinks."
	echo
}
