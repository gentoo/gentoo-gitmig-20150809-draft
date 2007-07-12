# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-0.3.9.ebuild,v 1.2 2007/07/12 10:06:46 uberlord Exp $

inherit libtool multilib autotools

DESCRIPTION="provides ASN.1 structures parsing capabilities for use with GNUTLS"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="http://josefsson.org/gnutls/releases/libtasn1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"
RDEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "installed failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	use doc && dodoc doc/asn1.ps
}

pkg_postinst() {
	if [[ -e ${ROOT}/usr/$(get_libdir)/libtasn1.so.2 ]] ; then
		ewarn "You must re-compile all packages that are linked against"
		ewarn "Libtasn1-0.2.* by using revdep-rebuild from gentoolkit:"
		ewarn "# revdep-rebuild --library libtasn1.so.2"
	fi
}
