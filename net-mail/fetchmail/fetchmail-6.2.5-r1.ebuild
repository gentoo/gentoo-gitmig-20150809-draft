# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.2.5-r1.ebuild,v 1.3 2004/11/03 04:24:04 psi29a Exp $

inherit eutils gnuconfig

DESCRIPTION="the legendary remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.catb.org/~esr/fetchmail/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~mips"
IUSE="ssl nls ipv6 kerberos krb4"

DEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6 )
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )
	krb4? ( app-crypt/kth-krb )
	sys-devel/autoconf"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-6.2.0-gentoo.diff || die
	epatch ${FILESDIR}/${P}-kerberos.patch
	# patch fixes bug #40126 (tomk@gentoo.org 2004-08-07)
	epatch ${FILESDIR}/${P}-fetchsizelimit.patch || die
	# this patch fixes bug #34788 (ticho@gentoo.org 2004-09-03)
	epatch ${FILESDIR}/${P}-broken-headers.patch || die
}

src_compile() {
	autoconf

	gnuconfig_update

	local myconf

	use ssl && myconf="${myconf} --with-ssl"
	use nls || myconf="${myconf} --disable-nls"
	use ipv6 && myconf="${myconf} --enable-inet6"
	use kerberos && myconf="${myconf} --with-gssapi --with-kerberos5"
	use krb4 && myconf="${myconf} --with-kerberos"

	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		${myconf} || die "Configuration failed."
	# wont compile reliably on smp (mkennedy@gentoo.org 2003-11-12)
	make || die "Compilation failed."
}

src_install() {
	einstall || die

	dohtml *.html

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README \
		README.NTLM README.SSL TODO COPYING MANIFEST

	doman ${D}/usr/share/man/*.1
	rm -f ${D}/usr/share/man/*.1

	exeinto /etc/init.d
	doexe ${FILESDIR}/fetchmail

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d-fetchmail fetchmail

	docinto contrib
	local f
	for f in contrib/*
	do
		[ -f "${f}" ] && dodoc "${f}"
	done
}

pkg_postinst() {
	if ! python -c "import Tkinter" >/dev/null 2>&1
	then
		einfo
		einfo "You will not be able to use fetchmailconf(1), because you"
		einfo "don't seem to have Python with tkinter support."
		einfo
		einfo "If you want to be able to use fetchmailconf(1), do the following:"
		einfo "  1.  Include 'tcltk' in USE variable in your /etc/make.conf."
		einfo "  2.  (Re-)merge Python."
		einfo
	fi

	einfo "Please see /etc/conf.d/fetchmail if you want to adjust"
	einfo "the polling delay used by the fetchmail init script."
}
