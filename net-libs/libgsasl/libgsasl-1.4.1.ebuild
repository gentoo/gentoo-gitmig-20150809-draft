# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgsasl/libgsasl-1.4.1.ebuild,v 1.5 2010/10/07 15:07:01 phajdan.jr Exp $

DESCRIPTION="The GNU SASL library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
SRC_URI="mirror://gnu/${PN/lib}/${P}.tar.gz"
LICENSE="GPL-3 LGPL-3"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
#   * ntlm - libntlm ( http://josefsson.org/libntlm/ )
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="idn kerberos nls"
DEPEND="nls? ( >=sys-devel/gettext-0.16.1 )
	kerberos? ( virtual/krb5 )
	idn? ( net-dns/libidn )"
RDEPEND="${DEPEND}
	!net-misc/gsasl"

src_compile() {
	econf \
		$(use_enable kerberos gssapi) \
		$(use_enable kerberos kerberos_v5) \
		$(use_with idn stringprep) \
		$(use_enable nls) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
