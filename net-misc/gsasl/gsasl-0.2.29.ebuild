# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsasl/gsasl-0.2.29.ebuild,v 1.3 2011/06/24 15:20:30 armin76 Exp $

DESCRIPTION="The GNU SASL client, server, and library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gnutls idn kerberos nls"
DEPEND="nls? ( >=sys-devel/gettext-0.16.1 )
	kerberos? ( virtual/krb5 )
	idn? ( net-dns/libidn )
	gnutls? ( net-libs/gnutls )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--enable-client \
		--enable-server \
		$(use_enable kerberos gssapi) \
		$(use_enable kerberos kerberosv5) \
		$(use_with idn stringprep) \
		$(use_enable nls) \
		$(use_with gnutls) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	doman doc/gsasl.1

	if use doc; then
		dodoc doc/*.{eps,ps,pdf}
		dohtml doc/*.html
		docinto examples
		dodoc examples/*.c
	fi
}
