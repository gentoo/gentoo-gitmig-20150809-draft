# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.2.2-r2.ebuild,v 1.1 2003/04/16 00:52:22 avenj Exp $

inherit eutils

DESCRIPTION="Fetchmail is a full-featured remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.catb.org/~esr/fetchmail/"
SRC_URI="http://www.catb.org/~esr/fetchmail/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="x86 ~alpha"
IUSE="ssl nls ipv6"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fetchmail-6.2.0-gentoo.diff || die
	epatch ${FILESDIR}/fetchmail-6.2.2-multiple-return-path.diff || die
}

src_compile() {
	local myconf
	use ssl && myconf="${myconf} --with-ssl=/usr"
	use nls || myconf="${myconf} --disable-nls"
	use ipv6 && myconf="${myconf} --enable-inet6"
	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		${myconf} || die "Configuration failed."
	emake || die "Compilation failed."
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
