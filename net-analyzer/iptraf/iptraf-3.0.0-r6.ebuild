# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-3.0.0-r6.ebuild,v 1.1 2010/11/28 09:29:02 jlec Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
HOMEPAGE="http://iptraf.seul.org/"
SRC_URI="ftp://iptraf.seul.org/pub/iptraf/${P}.tar.gz
	ipv6? ( mirror://gentoo/${P}-ipv6.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ipv6 suid unicode"

DEPEND=">=sys-libs/ncurses-5.2-r1[unicode?]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-Makefile.patch" \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-add-devnames.patch \
		"${FILESDIR}"/${P}-linux-headers.patch
	use unicode && epatch "${FILESDIR}/${P}-ncursesw.patch" #152883
	epatch \
		"${FILESDIR}/${P}-setlocale.patch" \
		"${FILESDIR}"/${P}-headerfix.patch \
		"${FILESDIR}"/${P}-vlan.patch \
		"${FILESDIR}"/${PV}-buffer-overflow.patch

	sed -i \
		-e 's:/var/local/iptraf:/var/lib/iptraf:g' \
		-e "s:Documentation/:/usr/share/doc/${PF}:g" \
		Documentation/*.* || die "sed doc paths"

	if use ipv6 ; then
		epatch "${DISTDIR}"/${P}-ipv6.patch.bz2

		# bug #126479 and bug #252874
		epatch "${FILESDIR}"/${P}-ipv6-glibc24-updated.patch
		epatch "${FILESDIR}"/${P}-ipv6-headerfix.patch #128965
	fi
}

src_compile() {
	if use suid ; then
		append-flags -DALLOWUSERS
	fi
	emake -C src CFLAGS="$CFLAGS" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin src/{iptraf,rawtime,rvnamed} || die
	dodoc FAQ README* CHANGES RELEASE-NOTES || die
	doman Documentation/*.8 || die
	dohtml -r Documentation/* || die
	keepdir /var/{lib,run,log}/iptraf || die
}

pkg_postinst() {
	if use suid ; then
		elog
		elog "You've chosen to build iptraf with run-as-user support"
		elog
		elog "The app now has this support, but for security reasons"
		elog "you need to run the following command to allow your users"
		elog "to suid-run it:"
		elog
		elog " # chmod 4755 /usr/sbin/iptraf"
		elog
	fi
}
