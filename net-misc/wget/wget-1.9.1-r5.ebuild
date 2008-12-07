# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.9.1-r5.ebuild,v 1.17 2008/12/07 06:00:15 vapier Exp $

inherit eutils flag-o-matic

PATCHVER=0.4
DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="debug ipv6 nls socks5 ssl static"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	socks5? ( net-proxy/dante )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/autoconf"

src_unpack() {
	unpack ${A} ; cd "${S}"
	local PATCHDIR=${WORKDIR}/patches
	EPATCH_SUFFIX="patch"
	EPATCH_MULTI_MSG="Applying Gentoo patches ..." epatch "${PATCHDIR}"/gentoo
	EPATCH_MULTI_MSG="Applying Debian patches ..." epatch "${PATCHDIR}"/debian
	EPATCH_MULTI_MSG="Applying Mandrake patches ..." epatch "${PATCHDIR}"/mandrake
	autoconf || die "autoconf failed"
}

src_compile() {
	use static && append-ldflags -static
	econf \
		--sysconfdir=/etc/wget \
		$(use_with ssl) $(use_enable ssl opie) $(use_enable ssl digest) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_with socks5 socks) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog MACHINES MAILING-LIST NEWS README TODO
	dodoc doc/sample.wgetrc
}
