# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsasl/gsasl-0.1.4.ebuild,v 1.2 2004/11/13 13:26:51 slarti Exp $

DESCRIPTION="The GNU SASL client, server, and library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
UPST_SRC=$P.tar.gz
SRC_URI="ftp://alpha.gnu.org/pub/gnu/gsasl/${UPST_SRC}"
LICENSE="LGPL-2.1"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
KEYWORDS="~x86 amd64 ~ppc"
IUSE="kerberos nls static"
PROVIDE="virtual/gsasl"
DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )"
RDEPEND="${DEPEND}
	!virtual/gsasl"

src_compile() {
	local myconf="--enable-client --enable-server"
	myconf="${myconf} $(use_enable kerberos gssapi)"
	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_enable static)"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS COPYING COPYING.DOC ChangeLog NEWS README README-alpha THANKS
}
