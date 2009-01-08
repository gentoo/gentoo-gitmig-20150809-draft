# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftp/ftp-0.17-r7.ebuild,v 1.8 2009/01/08 06:18:27 vapier Exp $

inherit eutils toolchain-funcs flag-o-matic

MY_P=netkit-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Standard Linux FTP client"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="ssl ipv6"

RDEPEND=">=sys-libs/ncurses-5.2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${MY_P}-ssl-0.2.patch
	epatch "${FILESDIR}"/${MY_P}-ipv6.patch #47507
	epatch "${FILESDIR}"/${MY_P}-dont-strcpy-overlapping.patch #104311
	epatch "${FILESDIR}"/${MY_P}-acct.patch #fedora
	epatch "${FILESDIR}"/${MY_P}-locale.patch #fedora
	epatch "${FILESDIR}"/${MY_P}-runique_mget.patch #fedora
	epatch "${FILESDIR}"/${MY_P}-security.patch #fedora
	epatch "${FILESDIR}"/${MY_P}-segv.patch #fedora
	epatch "${FILESDIR}"/${MY_P}-custom-cflags.patch
	epatch "${FILESDIR}"/${MY_P}-sigseg.patch #fedora, #199206
	epatch "${FILESDIR}"/${MY_P}-arg_max.patch #fedora, #226513
	epatch "${FILESDIR}"/${MY_P}-CPPFLAGS.patch #234599
	append-lfs-flags #101038
}

src_compile() {
	./configure \
		--prefix=/usr \
		$(use_enable ssl) \
		$(use_enable ipv6) \
		${EXTRA_ECONF} \
		|| die "configure failed"
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die "make failed"
}

src_install() {
	dobin ftp/ftp || die
	doman ftp/ftp.1 ftp/netrc.5
	dodoc ChangeLog README BUGS
}
