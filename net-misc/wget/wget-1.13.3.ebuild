# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.13.3.ebuild,v 1.1 2011/09/01 09:24:29 chainsaw Exp $

EAPI=4

inherit eutils flag-o-matic

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="debug idn ipv6 nls ntlm +ssl static"

RDEPEND="idn? ( net-dns/libidn )
	ssl? ( >=dev-libs/openssl-0.9.6b )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

REQUIRED_USE="ntlm? ( ssl )"

DOCS=( AUTHORS MAILING-LIST NEWS README doc/sample.wgetrc )

src_configure() {
	# openssl-0.9.8 now builds with -pthread on the BSD's
	use elibc_FreeBSD && use ssl && append-ldflags -pthread

	use static && append-ldflags -static
	econf \
		--disable-rpath \
		$(use_with ssl) $(use_enable ssl opie) $(use_enable ssl digest) \
		$(use_enable idn iri) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable ntlm) \
		$(use_enable debug)
}

src_install() {
	default

	use ipv6 && cat "${FILESDIR}"/wgetrc-ipv6 >> "${ED}"/etc/wgetrc

	sed -i \
		-e "s:/usr/local/etc:${EROOT}/etc:g" \
		"${ED}"/etc/wgetrc \
		"${ED}"/usr/share/man/man1/wget.1 \
		"${ED}"/usr/share/info/wget.info
}

pkg_preinst() {
	ewarn "The /etc/wget/wgetrc file has been relocated to /etc/wgetrc"
	if [[ -e ${EROOT}/etc/wget/wgetrc ]] ; then
		if [[ -e ${EROOT}/etc/wgetrc ]] ; then
			ewarn "You have both /etc/wget/wgetrc and /etc/wgetrc ... you should delete the former"
		else
			einfo "Moving /etc/wget/wgetrc to /etc/wgetrc for you"
			mv "${EROOT}"/etc/wget/wgetrc "${EROOT}"/etc/wgetrc
			rmdir "${EROOT}"/etc/wget 2>/dev/null
		fi
	fi
}
