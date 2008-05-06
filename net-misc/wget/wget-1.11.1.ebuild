# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.11.1.ebuild,v 1.5 2008/05/06 16:04:28 ranger Exp $

inherit eutils flag-o-matic

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="debug ipv6 nls socks5 ssl static"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	socks5? ( net-proxy/dante )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.11-linking.patch
}

src_compile() {
	# openssl-0.9.8 now builds with -pthread on the BSD's
	use elibc_FreeBSD && use ssl && append-ldflags -pthread

	use static && append-ldflags -static
	econf \
		$(use_with ssl) $(use_enable ssl opie) $(use_enable ssl digest) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_with socks5 socks) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* MAILING-LIST NEWS README
	dodoc doc/sample.wgetrc

	use ipv6 && cat "${FILESDIR}"/wgetrc-ipv6 >> "${D}"/etc/wgetrc

	sed -i \
		-e 's:/usr/local/etc:/etc:g' \
		"${D}"/etc/wgetrc \
		"${D}"/usr/share/man/man1/wget.1 \
		"${D}"/usr/share/info/wget.info
}

pkg_preinst() {
	ewarn "The /etc/wget/wgetrc file has been relocated to /etc/wgetrc"
	if [[ -e ${ROOT}/etc/wget/wgetrc ]] ; then
		if [[ -e ${ROOT}/etc/wgetrc ]] ; then
			ewarn "You have both /etc/wget/wgetrc and /etc/wgetrc ... you should delete the former"
		else
			einfo "Moving /etc/wget/wgetrc to /etc/wgetrc for you"
			mv "${ROOT}"/etc/wget/wgetrc "${ROOT}"/etc/wgetrc
			rmdir "${ROOT}"/etc/wget 2>/dev/null
		fi
	fi
}
