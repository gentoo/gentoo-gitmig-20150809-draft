# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.9.1-r5.ebuild,v 1.10 2005/05/21 18:47:54 vapier Exp $

inherit gnuconfig eutils flag-o-matic

IUSE="build debug ipv6 nls socks5 ssl static"

PATCHVER=0.3
DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://wget.sunsite.dk/"
SRC_URI="mirror://gnu/wget/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~seemant/distfiles/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	socks5? ( net-proxy/dante )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/autoconf"


PATCHDIR="${WORKDIR}/patches"

src_unpack() {
	unpack ${A} ; cd ${S}
	export EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}/gentoo
	epatch ${PATCHDIR}/debian
	epatch ${PATCHDIR}/mandrake
}

src_compile() {
	# Make wget use up-to-date configure scripts
	gnuconfig_update

	use ssl && append-flags -I/usr/include/openssl

	econf \
		--sysconfdir=/etc/wget \
		$(use_with ssl) $(use_enable ssl opie) $(use_enable ssl digest) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_with socks5 socks) \
		|| die

	if use static; then
		emake LDFLAGS="--static" || die
	else
		emake || die
	fi
}

src_install() {
	if use build; then
		insinto /usr
		dobin ${S}/src/wget
		return
	fi

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO
	dodoc doc/sample.wgetrc
}
