# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgsasl/libgsasl-0.2.10.ebuild,v 1.1 2006/01/02 15:57:55 slarti Exp $

DESCRIPTION="The GNU SASL library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
SRC_URI="http://josefsson.org/gsasl/releases/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kerberos nls static idn"
PROVIDE="virtual/gsasl"
DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )
	idn? ( net-dns/libidn )"
RDEPEND="${DEPEND}
	!virtual/gsasl"

src_compile() {
	econf \
		$(use_enable kerberos gssapi) \
		$(use_enable kerberos kerberosv5) \
		$(use_with idn stringprep) \
		$(use_enable nls) \
		$(use_enable static) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README README-alpha THANKS
}
